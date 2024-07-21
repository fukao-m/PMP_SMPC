classdef Model < handle
    properties
        n
        m
        r
        p
        N
        SetsObj
        A
        B
        E
        C
        lA
        lA_sym
        lB
        lB_sym
        lE
        lE_sym
        lC
        lC_sym
        lQ
        lQ_sym
        lR
        lR_sym
        lClAE
        lClAE_sym
        lClB
        lClB_sym
        lClE
        lClE_sym
        A_Default
        B_Default
        E_Default
        A_OverSamplingCycle
        B_OverSamplingCycle
        E_OverSamplingCycle
        x0
        haveAugMatCalculated = false
    end
    methods
        function model = Model(setsObj, A, B, E, C)

            import myParallelSMPC.Settings

            if nargin == 1
                filepath = setsObj;

                setsObj = Settings(filepath);
                    
                jsonContent = fileread(filepath);
                jsonContent = jsondecode(jsonContent);
                modelStruct = jsonContent.model;

                model.A = modelStruct.A;
                model.B = modelStruct.B;
                model.E = modelStruct.E;
                model.C = modelStruct.C;

            else
    
                model.A = A;
                model.B = B;
                model.E = E;
                model.C = C;
            
            end

            model.n = setsObj.n;
            model.m = setsObj.m;
            model.r = setsObj.r;
            model.p = setsObj.p;
            
            model.SetsObj = setsObj;

        end
        
        function augmentModelMatrix(model, N)
            % Calculate the matrix containing the coefficient matrices of the state equation at each time over the horizon, and the diagonal matrices Q and R．

            if model.haveAugMatCalculated ~= true
            
                n = model.n;
                m = model.m;
                r = model.r;
                p = model.p;
                
                model.N = N;
                
                A = model.A;
                B = model.B;
                E = model.E;
                C = model.C;
                Q = model.SetsObj.Q;
                R = model.SetsObj.R;
                
                % compute A^i (i=0, 1, ... , N)
                
                % define augmented A (lA)
                lA = zeros((N+1)*n, n); % initialize lA
                powA_i = eye(n); % A to the ith power (A^i)
                for i = 0 : N
                    lA(i*n+1:(i+1)*n, 1:n) = powA_i;
                    if i == N+1   % not to compute A^(N+1), which is not used for lA
                        break
                    end
                    powA_i = A * powA_i;
                end
                model.lA = lA;
                model.lA_sym = sym(lA);
                    
                % define augmented B (lB)
                lB = zeros((N+1)*n, N*m); % initialize lB
                powAB = B; % A^i * B
                for i = 0 : N-1
                    for j = 0 : N-i-1
                        lB((i+j+1)*n+1:(i+j+2)*n, j*m+1:(j+1)*m) = powAB;
                    end

                    if i == N   % not to compute A^N*B, which is not used for lB
                        break
                    end

                    powAB = A * powAB;
                end
                model.lB = lB;
                model.lB_sym = sym(lB);
                
                % define augmented E (lE) the same way as lB
                lE = zeros((N+1)*n, N*r);
                powAE = E; % A^i * E
                for i = 0 : N-1
                    for j = 0 : N-i-1
                        lE((i+j+1)*n+1:(i+j+2)*n, j*r+1:(j+1)*r) = powAE;
                    end

                    if i == N
                        break
                    end

                    powAE = A * powAE;
                end
                model.lE = lE;
                model.lE_sym = sym(lE);
                
                lC = zeros((N+1)*p, (N+1)*n);
                for i = 0 : N
                    lC(i*p+1:(i+1)*p, i*n+1:(i+1)*n) = C;
                end
                model.lC = lC;
                model.lC_sym = sym(lC);

                lQ = zeros((N+1)*n, (N+1)*n);
                for i = 0 : N
                    lQ(n*i+1:n*(i+1), n*i+1:n*(i+1)) = Q;
                end
                model.lQ = lQ;
                model.lQ_sym = sym(lQ);
                    
                lR = zeros(N*m, N*m);
                for i = 0 : N-1
                    lR(m*i+1:m*(i+1), m*i+1:m*(i+1)) = R;
                end
                model.lR = lR;
                model.lR_sym = sym(lR);

                model.haveAugMatCalculated = true;
            end
        end

        function changeModelToOverSamplingCycle(model)
            model.A = model.A_OverSamplingCycle;
            model.B = model.B_OverSamplingCycle;
            model.E = model.E_OverSamplingCycle;
        end
        
        function changeModelFromOverSamplingCycle(model)
            model.A = model.A_Default;
            model.B = model.B_Default;
            model.E = model.E_Default;
        end

        function setInitialState(model, x0)
            
            if size(x0, 2) ~= 1
                x0 = x0';
            end

            model.x0 = x0;
        end

        function next_x = stateEquationArray(model, x, u, w)
        
            n = model.n;
            m = model.m;
            r = model.r;

            A = model.A;
            B = model.B;
            E = model.E;

            switch nargin
                case 3
                    next_x = A * reshape(x, n, 1) + B * reshape(u, m, 1);
                case 4
                    next_x = A * reshape(x, n, 1) + B * reshape(u, m, 1) + E * reshape(w, r, 1);
                otherwise
                    warning('Check the number of arguments')
            end
        end

        function x = predictState(model, x, inputList)
        
            for i = 1 : length(inputList)
                x = model.stateEquationArray(x, inputList(i));
            end 
        end

        function r = J(model, x, u)

            r = x' * model.lQ * x + u' * model.lR * u;
            
        end

        function r = J_adf(model, x0, M, h)
            
            N = model.N;
            n = model.n;
            m = model.m;
            
            lA = model.lA;
            lB = model.lB;
            lE = model.lE;
            
            lQ = model.lQ;
            lR = model.lR;

            r = h' * (lB' * lQ * lB + lR) * h  ...
                    + 2 * h' * lB' * lQ * lA * x0  ...
                    + trace( M' * (lB' * lQ * lB + lR) * M ...
                    + 2 * M' * lB' * lQ * lE);
            
        end

        function r = J_adf_sym(model, x0, M, h)
            
            N = model.N;
            n = model.n;
            m = model.m;
            
            lA = model.lA_sym;
            lB = model.lB_sym;
            lE = model.lE_sym;            
            lQ = model.lQ_sym;
            lR = model.lR_sym;

            r = h' * (lB' * lQ * lB + lR) * h ...
                    + 2 * h' * lB' * lQ * lA * x0  ...
                    + trace( M' * (lB' * lQ * lB + lR) * M ...
                    + 2 * M' * lB' * lQ * lE);
            
        end

        function r = J_adf_M(model, x0, M)

            N = model.N;
            n = model.n;
            m = model.m;
            
            lA = model.lA;
            lB = model.lB;
            lE = model.lE;
            lQ = model.lQ;
            lR = model.lR;
                
            r = trace( M' * (lB' * lQ * lB + lR) * M + 2 * M' * lB' * lQ * lE);
        end

        function r = J_adf_h(model, x0, h)

            N = model.N;
            n = model.n;
            m = model.m;
            Q = model.SetsObj.Q;
            R = model.SetsObj.R;
            
            lA = model.lA;
            lB = model.lB;
            lE = model.lE;
            lQ = model.lQ;
            lR = model.lR;
                
            r = h.' * (lB.' * lQ * lB + lR) * h  +  2 * h.' * lB.' * lQ * lA * x0;
        end

        function r = J_adf_h_sym(model, x0, h)

            N = model.N;
            n = model.n;
            m = model.m;
            
            lA = model.lA_sym;
            lB = model.lB_sym;
            lE = model.lE_sym;
            lQ = model.lQ_sym;
            lR = model.lR_sym;
                
            r = h.' * (lB.' * lQ * lB + lR) * h  +  2 * h.' * lB.' * lQ * lA * x0;
        end

        % Ci(Ax0 + Bh)
        function r = exp_x(model, i, x0, h)
            r = model.lC(i, :) * (model.lA * x0 + model.lB * h);
        end
            
        % ||Ci(BM+E)||
        function r = dist_x(model, i, M)
            r = norm(model.lC_sym(i, :) * (model.lB_sym * M + model.lE_sym));
        end
        
        function r = dist_x_modJP(model, i, M, k, M_pre)
            %{
            dist_x_modJP
                Constraints on x considering one-time step prediction
            Input:
                i : index of constraint on x
                M : decision variable M
                k : the number of delay step
            %}

            n = model.n;
            m = model.m;
            r = model.r;

            switch nargin
                case 3
                    k = 1;
                    M_pre = zeros(m, r);
                case 4
                    warning('set previously optimized M to Model.dist_x_modJP()')
            end

            lB_k = model.lB_sym(k*n+1:(k+1)*n, 1:m*k);
            lE_k = model.lE_sym(k*n+1:(k+1)*n, 1:r*k);
            M_k = M_pre(1:m*k, 1:r*k);
            lD_k = lB_k * M_k + lE_k;
            r =  norm(model.lC_sym(i, :) * [model.lA_sym * lD_k, model.lB_sym * M + model.lE_sym]);
        end
        
        % hi
        function r = exp_u(~, i, h)
            r = h(i);
        end
            
        % ||Mi||
        function r = dist_u(~, i, M)
            r = norm(M(i, :), 2);
        end
    end
end