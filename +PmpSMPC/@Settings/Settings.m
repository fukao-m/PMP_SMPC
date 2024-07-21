classdef Settings < handle
    properties
        T
        dt
        Nt
        Nh
        dtau
        x0
        Q
        R
        Q_array
        R_array
        bound
        alpha_x
        alpha_u
        options
        n
        m
        r
        p
    end

    methods
        function sets = Settings(n, m, r, p, T, dt, N, dtau, x0, Q, R, bound, alpha_x, alpha_u, options)

            if nargin == 1
                % If a JSON file is provided
                
                filepath = n;
                
                jsonContent = fileread(filepath);
                jsonContent = jsondecode(jsonContent);
                setStruct = jsonContent.settings;

                sets.n = setStruct.n;
                sets.m = setStruct.m;
                sets.r = setStruct.r;
                sets.p = setStruct.p;

                sets.T = setStruct.T;
                sets.dt = setStruct.dt;
                sets.Nt = round(setStruct.T/setStruct.dt);
                
                sets.Nh = setStruct.Nh;
                sets.dtau = setStruct.dtau;
                
                sets.x0 = setStruct.x0;

                if size(sets.x0, 2) ~= 1
                    sets.x0 = sets.x0';
                end
                
                sets.Q = setStruct.Q;
                sets.Q_array = setStruct.Q;
                sets.R = setStruct.R;
                sets.R_array = setStruct.R;
                
                sets.bound = setStruct.bound;
                
                sets.alpha_x = setStruct.alpha_x;
                sets.alpha_u = setStruct.alpha_u;
                
                sets.options = setStruct.options;
            else
                sets.n = n;
                sets.m = m;
                sets.r = r;
                sets.p = p;
    
                sets.T = T;
                sets.dt = dt;
                sets.Nt = round(T/dt);
                
                sets.Nh = N;
                sets.dtau = dtau;
                
                sets.x0 = x0;
                
                sets.Q = Q;
                sets.Q_array = Q;
                sets.R = R;
                sets.R_array = R;
                
                sets.bound = bound;
                
                sets.alpha_x = alpha_x;
                sets.alpha_u = alpha_u;
                
                sets.options = options;

            end

        end
            
        function get_info(sets)
            disp("---------------simulation information---------------")
            disp("Simulation length: " + num2str(sets.T))
            disp("Time shift: " + num2str(sets.dt))
            disp("Horizon length: " + num2str(sets.Nh * sets.dt))
            disp("Initial values: " + num2str(sets.x0))
            disp("Object function's coefficient about state: ")
            disp(sets.Q_np)
            disp("Object function's coefficient about input: ")
            disp(sets.R_np)
            disp("Bounds of input")
            disp(num2str(sets.bound(0,0)) + "< u <" + num2str(sets.bound(0,1)))
            disp("Bounds of the room temperature")
            disp(num2str(sets.bound(1,0)) + "< x <" + num2str(sets.bound(1,1)))
        end
    end
end