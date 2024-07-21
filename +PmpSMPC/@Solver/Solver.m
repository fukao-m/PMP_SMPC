classdef Solver < handle
    properties
        SetsObj
        ModelObj
        SystemObj
        config

        seriesResults
        timeResults
    end
    methods
        function sol = Solver(setsObj, model_obj, system_obj, config)

            sol.SetsObj = setsObj;
            sol.ModelObj = model_obj;
            sol.SystemObj = system_obj;
            
            jsonContent = fileread(config);
            jsonContent = jsondecode(jsonContent);
            sol.config = jsonContent.solver;
        end

        function seriesResults = solve(sol, solverList)
            seriesResults = cell(length(solverList), 1);
            sol.timeResults = cell(length(solverList), 1);

            for i = 1 : length(solverList)
                solver = solverList(i);

                switch solver
                    case "Proposed method"
                        result = sol.smpc_adf_actual_ProposedMethod();
                    case "smpc_adf"
                        result = sol.smpc_adf_actual_delay1();
                    otherwise
                        warning("Error on Solver.solve(): I don't know the following solver name")
                        warning(solver_list(i))
                        warning("so please confirm the name or register it")
                end
                
                seriesResults{i} = result{1};
                sol.timeResults{i} = result{2};
            end
        end

        function data = getTimeData(sol)
            data = sol.timeResults;
        end

        function Mh_vec_opt = socp_adf(sol, Mh0, itr, solver)
            disp("started socp_adf")
            %{
            Function: solve the optimization problem of Stochastic MPC using Affine Disturbance Feedback

            Input:
                Mh0: vector (n_M + n_h, 1) 
                    initial values of decision variables M, h
                itr: int
                    index of iterations in MPC
                solver: str
                    solver's name, which is written in solve method

            Output:
                Mh_vec_opt: vector (n_M + n_h, 1)
                    optimal variables in vector form

            where:
                N : horizen length
                m : dim of input
                r : dim of noise (disturbance)

                n_M = N*(N-1)*m*r/2 (int)
                    the number of nonzero elements of M
                n_h = N*M (int)
                    the number of elements of h
            %}

            N = sol.SetsObj.Nh;
            m = sol.SetsObj.m;
            r = sol.SetsObj.r;
            
            % define optimal control problem
            %{
                Decision variables and parameters of this optimal control problem
                    Decision variables: [M_vec; h]
                    Parameters of constraints : x0
                    Parameters of objective function : x0
                where 
                    x0 : x(t) (t = current time)
            %}

            %% parameters of OCP
            x0 = sol.ModelObj.x0;

            probParamsObjective = x0;
            probParamsConstr    = x0;

            Mh_vec_opt = sol.solveOcp("Adf", N, Mh0, probParamsObjective, probParamsConstr);
        end

        function Mh_vec_opt = socp_adf_modJP(sol, Mh0, itr, solver, Mh_pre_or_h_pre, n_delay)
            disp("started socp_adf_modJP")
            %{
            Function: solve the optimization problem of Stochastic MPC using Affine Disturbance Feedback with delay

            Input:
                Mh0: vector (n_M + n_h, 1) 
                    initial values of decision variables M, h
                itr: int
                    index of iterations in MPC
                solver: str
                    solver's name, which is written in solve method
                Mh_pre_or_h_pre : array(n_M+n_h, 1) or array(n_h, 1)
                    Mh_pre or h_pre
                n_delay : int
                    the steps of delay

            Output:
                Mh_vec_opt: vector (n_M + n_h, 1)
                    optimal variables in vector form

            where:
                N : horizen length
                m : dim of input
                r : dim of noise (disturbance)

                n_M = N*(N-1)*m*r/2 (int)
                    the number of nonzero elements of M
                n_h = N*M (int)
                    the number of elements of h
            %}
        
            N = sol.SetsObj.Nh;
            m = sol.SetsObj.m;
            r = sol.SetsObj.r;

            n_M = round(N*(N-1)*m*r/2);
            n_h = N*m;

            if length(Mh_pre_or_h_pre) == n_h
                M_vec_pre = zeros(n_M, 1);
                h_pre     = Mh_pre_or_h_pre;
            elseif length(Mh_pre_or_h_pre) == n_M + n_h
                M_vec_pre = Mh_pre_or_h_pre(1:n_M, :);
                h_pre     = Mh_pre_or_h_pre(n_M+1:n_M+n_h, :);
            else 
                warning("the length of input param Mh_pre(or h_pre) must be %d (Mh_pre) or %d (h_pre), not %d", ...
                                                                            n_M + n_h,     n_h,            length(Mh_pre_or_h_pre))
            end

            % define optimal control problem
            %{
                Decision variables and parameters of this optimal control problem
                    Decision variables: [M_vec; h]
                    Parameters of constraints : [x0; M_vec_pre; h_pre]
                    Parameters of objective function : [x0; h_pre]
                where 
                    x0 : x(t) (t = current time)
                    M_vec_pre, h_pre : optimal values M, h used to calculate u(t) (t = current time)
            %}

            %% parameters of OCP
            x0 = sol.ModelObj.x0;

            probParamsObjective = [x0; h_pre];
            probParamsConstr    = [x0; M_vec_pre; h_pre];

            Mh_vec_opt = sol.solveOcp("AdfTime", N, Mh0, probParamsObjective, probParamsConstr, struct("n_delay", n_delay));
        end

        function h_opt = sub_h_modJP(sol, h0, itr, solver, u0, M_given_vec)
            disp("started socp_adf_modJP")
            %{
            Function: solve the optimization problem of Stochastic MPC using Affine Disturbance Feedback

            Input:
                Mh0: vector (n_M + n_h, 1) 
                    previously calculated optimal variables M, h in vector form
                itr: int
                    index of iterations in MPC
                solver: str
                    solver's name, which is written in solve method
                u0: array(m, 1)
                    u(t)
                M_given_vec :  array(n_M, 1)
                    given M to calculate h

            Output:
                h_opt: vector (n_h, 1)
                    optimal variable h

            where:
                N : horizen length
                m : dim of input
                r : dim of noise (disturbance)

                n_M = N*(N-1)*m*r/2 (int)
                    the number of nonzero elements of M
                n_h = N*M (int)
                    the number of elements of h
            %}
        
            N = sol.SetsObj.Nh;
            m = sol.SetsObj.m;
            r = sol.SetsObj.r;

            % define optimal control problem
            %{
                Decision variables and parameters of this optimal control problem
                    Decision variables: h
                    Parameters of constraints : [x0; u0; M_given]
                    Parameters of objective function : [x0; u0]
                where 
                    x0 : x(t) (t = current time)
                    M_given : given M to calculate h
            %}

            %% parameters of OCP
            x0 = sol.ModelObj.x0;

            probParamsObjective = [x0; u0];
            probParamsConstr    = [x0; u0; M_given_vec];

            h_opt = sol.solveOcp("AdfPartTime", N, h0, probParamsObjective, probParamsConstr);

        end
      
        function result = smpc_adf_actual_ProposedMethod(sol)
            
            solvername = "adf_actual_ProposedMethod";

            import myParallelSMPC.*

            N = sol.SetsObj.Nt;
            Nh = sol.SetsObj.Nh;
            n = sol.SetsObj.n;
            m = sol.SetsObj.m;
            r = sol.SetsObj.r;
            
            n_M = round(Nh*(Nh-1)*m*r/2);
            n_h = Nh*m;

            memoObj = Memory(sol.SetsObj, true);

            sol.ModelObj.augmentModelMatrix(Nh);

            % get the properties of Settings object
            options = sol.SetsObj.options;
            n_thread = options.n_thread;
            T_Adf = options.T_Adf;
            T_AdfPart = options.T_AdfPart;
            samplingTime = max(T_AdfPart, (T_Adf + T_AdfPart) / n_thread);

            totalTime = 2 * (N - n_thread + 2)*samplingTime + T_Adf;
            disp(['total time is ', num2str(totalTime), ' s'])

            % check whether we can compute parallelly
            if (rem(T_Adf, samplingTime)==0) && (rem(T_AdfPart, samplingTime)==0)
                disp('we can compute parallelly')
            else
                warning('we can not compute parallelly')
            end

            % predefine optimal control problem
            %% make files about information of objective function and constraints
            problemPath = sol.config.problem_path;
            problemAdfPath = sol.makeSymbolicProblem(sol.ModelObj, sol.SetsObj, Nh, problemPath, "Adf");
            problemAdfTimePathList = [];
            for idx = 1 : n_thread
                ocp_options = struct("n_delay", idx);
                problemAdfTimePath = sol.makeSymbolicProblem(sol.ModelObj, sol.SetsObj, Nh, problemPath, "AdfTime", ocp_options);
                problemAdfTimePathList = [problemAdfTimePathList, problemAdfTimePath];
            end
            problemAdfPartPath = sol.makeSymbolicProblem(sol.ModelObj, sol.SetsObj, Nh, problemPath, "AdfPartTime");

            %% pass path
            addpath(problemAdfPath)
            for idx = 1 : n_thread
                addpath(problemAdfTimePathList(idx))
            end
            addpath(problemAdfPartPath)
            
            % decide default inputs (used until the end of first online computation) and store it into memory
            %% set memory
            memoryToAdf_Mh = zeros(n_thread, n_M+n_h, 1);

            %% initial state
            x0 = sol.SetsObj.x0;

            %% deterministic h (for considering past input)
            h_pre_det = zeros(n_h, 1);

            %% first input of default inputs
            sol.ModelObj.setInitialState(x0);
            Mh0 = repmat(0.1, n_M+n_h, 1);
            Mh_vec_opt = sol.socp_adf(Mh0, 1, solvername);
            h_opt = Mh_vec_opt(n_M+1:end);
            u_opt = h_opt(1:m);
            sol.SystemObj.setInput(u_opt, 1);

            memoryToAdf_Mh(1, :, :) = Mh_vec_opt;
            h_pre_det(1:m, :) = u_opt;

            %% other inputs of default inputs
            for idx = 2 : n_thread
                sol.ModelObj.setInitialState(x0);
                Mh_vec_opt = sol.socp_adf_modJP(Mh_vec_opt, idx, solvername, h_pre_det, idx-1);
                h_opt = Mh_vec_opt(n_M+1:end);
                u_opt = h_opt(1:m);
                sol.SystemObj.setInput(u_opt, idx);

                memoryToAdf_Mh(idx, :, :) = Mh_vec_opt;
                h_pre_det((idx-1)*m+1:idx*m, :) = u_opt;
            end
            memoObj.setDefaultMh(memoryToAdf_Mh);

            delete(gcp('nocreate'))

            p = parpool('local', n_thread);
            
            disp("-------------------- warming up ------------------")
            ticBytes(p);
            
            % warming up for memory
            % warmingup_future(n_thread) = parallel.FevalFuture();

            % for idx = 1 : n_thread 
            %     M_vec_pre = repmat(0.1, n_M, 1);
            %     h_pre = repmat(0.1, n_h, 1);
            %     warmingup_future(idx) = parfeval(p, @sol.socp_adf_modJP_par, 1, x0, Nh, m, r, M_vec_pre, h_pre, n_thread-1);
            % end

            % for idx = 1 : n_thread
            %     Mh_vec = fetchOutputs(warmingup_future(idx));
            % end

            % warming up

            % systemObj = copy(sol.SystemObj);

            % tAdf = timer('StartDelay', 0, 'Period', samplingTime, 'TasksToExecute', n_thread, 'ExecutionMode', 'fixedRate', 'BusyMode', 'error');
            % tAdf.TimerFcn = {@sol.callbackAdf, p, tAdf, systemObj, sol.SetsObj, memoObj};

            % spareTime = 1;
            % pause(T_Adf + samplingTime * n_thread + spareTime)

            tocBytes(p)

            disp("-------------------- online computation ------------------")

            ticBytes(p);

            sol.SystemObj.setTic(tic, "startOnlineSMPC");
            tAdf = timer('StartDelay', 0, 'Period', samplingTime, 'TasksToExecute', N-n_thread, 'ExecutionMode', 'fixedRate', 'BusyMode', 'error');
            tAdf.TimerFcn = {@sol.callbackAdf, p, tAdf, sol.SystemObj, sol.SetsObj, memoObj};

            tAdfPart = timer('StartDelay', T_Adf, 'Period', samplingTime, 'TasksToExecute', N-n_thread+1, 'ExecutionMode', 'fixedRate', 'BusyMode', 'error');
            tAdfPart.TimerFcn = {@sol.callbackAdfPart, p, tAdfPart, sol.SystemObj, sol.SetsObj, memoObj};

            % statusCheker = timer('StartDelay', 0, 'Period', samplingTime/10, 'TasksToExecute', N, 'ExecutionMode', 'fixedRate');
            % statusCheker.TimerFcn = {@sol.checkStatus, sol.SystemObj};

            start([tAdf, tAdfPart])

            % pause(totalTime)
            pause(totalTime)

            tocBytes(p)

            delete([tAdf, tAdfPart])

            result = sol.SystemObj.getResult();
            delete(p)
        end

        function result = smpc_adf_actual_delay1(sol)

            solvername = "adf_actual_delay1";
            
            N = sol.SetsObj.Nt;
            Nh = sol.SetsObj.Nh;
            m = sol.SetsObj.m;
            r = sol.SetsObj.r;
            
            n_delay = 1;

            %%% calculation in offline

            % define problem in symbolic form
            problemPath = sol.config.problem_path;
            problemAdfPath     = sol.makeSymbolicProblem(sol.ModelObj, sol.SetsObj, Nh, problemPath, "Adf");
            problemAdfTimePath = sol.makeSymbolicProblem(sol.ModelObj, sol.SetsObj, Nh, problemPath, "AdfTime", struct("n_delay", 1));
            addpath(problemAdfPath)
            addpath(problemAdfTimePath)

            % calculate block-matrix of state transition (model.lA, model.lB, ...)
            sol.ModelObj.augmentModelMatrix(Nh);
            
            % calculate initial input
            n_M = round(Nh*(Nh-1)*m*r/2);
            n_h = Nh*m;
            
            Mh_vec_opt = repmat(10.0, n_M + n_h, 1);

            x0 = sol.SystemObj.getStateAt(1);
            sol.ModelObj.setInitialState(x0);

            Mh_vec_opt = sol.socp_adf(Mh_vec_opt, 0, solvername);
            h_opt = Mh_vec_opt(n_M+1:end, :);
            u0 = h_opt(1); % use first input
            sol.SystemObj.setInput(u0, n_delay);

            %%%

            % solve optimal control problem N times
            for idx = 1 : N - n_delay
                disp(idx)
                
                % get current state
                x0 = sol.SystemObj.getStateAt((idx-1)*n_delay+1);
                sol.ModelObj.setInitialState(x0);
                
                % solve optimal control problem for the future
                Mh_vec_opt = sol.socp_adf_modJP(Mh_vec_opt, idx, solvername, Mh_vec_opt, n_delay);
                [M_opt, h_opt] = sol.vec2mat_Mh(Mh_vec_opt, Nh, m, r);
                u0 = h_opt(1:m);  % use first input
                sol.SystemObj.setInput(u0, idx+n_delay);
                
                % set objective function values
                h_k = h_opt(1:n_delay);
                x0_pred = sol.ModelObj.predictState(x0, h_k);
                J = sol.ModelObj.J_adf(x0_pred, M_opt, h_opt);
                sol.SystemObj.set_J(J, idx+n_delay); % set a object value
            
            end
            
            result = sol.SystemObj.getResult();
        end

        function M_vec = socp_adf_modJP_par(sol, x0, N, m, r, M_vec_pre, h_pre, n_delay)

            n_M = round(N*(N-1)*m*r/2);
            n_h = N*m;
        
            % coldstart
            Mh0 = repmat(10.0, n_M+n_h, 1);
        
            % define optimal control problem
            %{
                Decision variables and parameters of this optimal control problem
                    Decision variables: [M_vec; h]
                    Parameters of constraints : [x0; M_vec_pre; h_pre]
                    Parameters of objective function : [x0; h_pre]
                where 
                    x0 : x(t) (t = current time)
                    M_vec_pre, h_pre : optimal values M, h used to calculate u(t) (t = current time)
            %}
        
            %% parameters of OCP
            probParamsObjective = [x0; h_pre];
            probParamsConstr    = [x0; M_vec_pre; h_pre];
        
            idname = sol.makeIdName_AdfTime(N, struct("n_delay", n_delay));
        
            %% define objective function, constraints and hessian of Lagrange function
            objective    = str2func(append("objective_",    idname));
            constraint   = str2func(append("constraint_",   idname));
            LagrangeHess = str2func(append("LagrangeHess_", idname));
        
            objective    = @(decVars) objective( [decVars; probParamsObjective]);
            constraint   = @(decVars) constraint([decVars; probParamsConstr]);
            LagrangeHess = @(decVars, lambda) LagrangeHess(decVars, probParamsObjective, probParamsConstr, lambda);
        
            % compute optimal values
            options = optimoptions(@fmincon,'Algorithm','interior-point','SpecifyObjectiveGradient',true,...
                'SpecifyConstraintGradient',true, 'HessianFcn',LagrangeHess, 'Display','final');
            [optimalDecVars, ~,~,~] = fmincon(objective, Mh0,...
                [],[],[],[],[],[],constraint, options);
        
            M_vec = optimalDecVars(1:n_M, 1);
        end
        
        function idname = makeIdName_AdfTime(sol, Nh, options)
            %{
            Function makeIdName_AdfTime:
                Name uniquely based on each condition. For AdfTime.
        
            Input
                Nh                : Horizon length
                option (struct)   : Option
        
            Output
                idname (string)   : ID
            %}
        
            solvername = "AdfTime";
        
            idname = append(solvername, "_Nh", num2str(Nh));
            
            %% option
            if length(fieldnames(options)) > 0
                
                fienames = fieldnames(options);
        
                for idx = 1 : length(fienames)
                    field = fienames{idx};
                    val = getfield(options, field);
        
                    if isstring(val)
                        idname = append(idname, "_", field, "_", val);
                    elseif ischar(val)
                        idname = append(idname, "_", field, "_", string(val));
                    elseif isnumeric(val) && (length(val) == 1)
                        idname = append(idname, "_", field, string(num2str(val)));
                    end
                end
            end
            
        end
    end

    % static methods in another files
    methods(Static)
        optimalDecVars = solveOcp(solvername, Nh, initDecVars, probParamsObjective, probParamsConstr, options)

        newdirpath = makeSymbolicProblem(modelObj, setsObj, Nh, dirpath, solvername, options)
        saveObjectiveFunc(modelObj, Nh, dirpath, solvername, options)
        n_constraint = saveConstraint(setsObj, modelObj, Nh, dirpath, solvername, options)
        saveLagrangeHess(n_constr, Nh, dirpath, solvername, options)

        [M, h] = vec2mat_Mh_sym(Mh_vec, N, m, r)
        [M, h] = vec2mat_Mh(Mh_vec, N, m, r)
        M = vec2mat_M_sym(M_vec, N, m, r)
        M = vec2mat_M(M_vec, N, m, r)

        idname = makeIdName(solvername, Nh, options)

        callbackAdf(~, ~, p, t, systemObj, setsObj, memoObj, modelObj, ocpsol)
        callbackAdfPart(~, ~, p, t, systemObj, setsObj, memoObj, modelObj, ocpsol)
        ocpsol = defineOcpAdf(A, B, E, C, setsObj)
        ocpsol = defineOcpAdfPart(A, B, E, C, setsObj)
    end
end