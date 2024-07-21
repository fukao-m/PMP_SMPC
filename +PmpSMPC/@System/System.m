classdef System < matlab.mixin.Copyable % < handle
    properties
        n
        m
        r
        Nt
        SetsObj
        ModelObj
        w
        x
        u
        x0
        objectValuesOfM
        objectValuesOfh
        objectValues
        isSeparated
        TicList
        TimeData
    end

    methods
        function sys = System(setsObj, model_sys, noise)
            import casadi.*

            sys.ModelObj = model_sys;
            sys.w = noise;
            
            sys.n = setsObj.n;
            sys.m = setsObj.m;
            
            sys.Nt = setsObj.Nt;
            
            sys.x0 = setsObj.x0;
            sys.x = zeros(sys.Nt, sys.n);
            sys.x(1, :) = reshape(setsObj.x0, 1, sys.n);
            sys.u = NaN(sys.Nt, sys.m);
            
            sys.objectValuesOfM = NaN(sys.Nt, 1);
            sys.objectValuesOfh = NaN(sys.Nt, 1);
            sys.objectValues = zeros(sys.Nt, 1);
        end

        function resetSystemProp(sys)
            
            n = sys.n;
            m = sys.m;
            
            Nt = sys.Nt;
            
            sys.x = zeros(Nt, n);
            sys.x(1, :) = reshape(sys.x0, 1, n);
            sys.u = NaN(Nt, m);
            
            sys.objectValuesOfM = NaN(Nt, 1);
            sys.objectValuesOfh = NaN(Nt, 1);
            sys.objectValues = zeros(Nt, 1);

            sys.TicList = struct;
            sys.TimeData = struct;
        end

        function stateTransition(sys, i)
            n = sys.n;
            
            wi = sys.w(i, :);
            
            if i < sys.Nt
                sys.x(i+1, :) = reshape(sys.ModelObj.stateEquationArray(sys.x(i, :), sys.u(i, :), wi), 1, n);
            end
        end

        function result = getResult(sys)
            result = cell(2,1);

            result{1} = sys.getSeriesData();
            result{2} = sys.getTimeData();

            sys.resetSystemProp();
        end

        function data = getTimeData(sys)
            data = sys.TimeData;
        end


        function tableAll = getSeriesData(sys)
            table_x = array2table(sys.x, 'VariableNames',{'x1', 'x2', 'x3'});
            table_u = array2table(sys.u, 'VariableNames',{'u'});
            table_t = array2table((0 : sys.Nt-1)', 'VariableNames',{'t'});
            
            if sys.isSeparated == true
                table_J_M = array2table(sys.objectValuesOfM, 'VariableNames',{'J_M'});
                table_J_h = array2table(sys.objectValuesOfh, 'VariableNames',{'J_h'});

                % concatenate these tables
                tableAll = [table_x, table_u, table_t, table_J_M, table_J_h];

                % create J column
                tableAll{:, {'J'}} = tableAll{:, {'J_M'}} + tableAll{:,{'J_h'}};
                       
            elseif sys.isSeparated == false
                table_J = array2table(sys.objectValues, 'VariableNames',{'J'});

                % concatenate these tables
                tableAll = [table_x, table_u, table_t, table_J];

            else
                tableAll = [table_x, table_u, table_t];
            end
        end

        function state = getStateAt(sys, i)            
            state = reshape(sys.x(i, :), sys.n, 1);
        end

        function in = getInputAt(sys, i)            
            in = reshape(sys.u(i, :), sys.m, 1);
        end

        function setTic(sys, tic_, ticTitle)
            sys.TicList.(ticTitle) = tic_;
        end

        function measureTime(sys, ticArg, timeDataTitle, idx)

            % ticArgをticTitleで与える場合．(sys.setTicで事前にticを用意する必要がある)
            if isstring(ticArg)
                tic_ = sys.TicList.(ticArg);

            % ticArgをtic関数で与える場合．
            elseif class(ticArg) == "uint64"
                tic_ = ticArg;
            end

            time = toc(tic_);

            if exist('idx', 'var')
                sys.TimeData.(timeDataTitle)(idx) = time;
            else
                if isfield(sys.TimeData, timeDataTitle)
                    sys.TimeData.(timeDataTitle) = [sys.TimeData.(timeDataTitle), time];
                else
                    sys.TimeData.(timeDataTitle) = [time];
                end
            end
        end
            
        function setInput(sys, u, i)

            if i < sys.Nt+1
                sys.u(i, :) = u;
            
                sys.stateTransition(i);
            end
        end
            
        % for setting sysect value of M
        function set_J_M(sys, J_M, i)
            
            if i < sys.Nt+1
                sys.isSeparated = true;
                sys.objectValuesOfM(i) = J_M;
            end
        end
            
        function set_J_h(sys, J_h, i)

            if i < sys.Nt+1
                sys.isSeparated = true;
                sys.objectValuesOfh(i) = J_h;
            end
        end
            
        function set_J(sys, J, i)
            
            if i < sys.Nt+1
                sys.isSeparated = false;
                sys.objectValues(i) = J;
            end
        end

    end

end