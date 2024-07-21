classdef Plotter < handle
    properties
        SettingsObj
    end

    methods
        function plt = Plotter(settingsObj)
            import casadi.*

            plt.SettingsObj = settingsObj;
        end

        function tableAll = prepareTable(plt)
            dt = plt.SettingsObj.dt;
            Nt = plt.SettingsObj.Nt;
            bound = plt.SettingsObj.bound;
            
            lbu = repmat(bound(1,1), Nt, 1);
            ubu = repmat(bound(1,2), Nt, 1);
            lbg = repmat(bound(2,1), Nt, 1);
            tableBound = array2table([lbu,ubu,lbg], 'VariableNames',{'lbu', 'ubu', 'lbg'});
            table_t = array2table((0:Nt-1)', 'VariableNames',{'t'});
            
            tableAll = [tableBound, table_t];
        end

        % use this method with Solver.solve
        function plot(plt, results, solver, titleName, ext)
        
            tablePre = plt.prepareTable();
            
            t = tiledlayout(2,2,'TileSpacing','Compact');
            title(t, titleName)

            nexttile
            for idx = 1 : length(solver)
                result = results{idx};
                plot(result.t, result.u)
                hold on
            end
            
            plot(tablePre.t, tablePre.lbu, tablePre.t, tablePre.ubu)
            
            xlabel('Time [h]')
            ylabel('Energy usage [Wh/m2]')
            title('Input')
            legend(solver)
            hold off

            nexttile
            for idx = 1 : length(solver)
                result = results{idx};
                plot(result.t, result.x1)
                hold on
            end
            
            plot(tablePre.t, tablePre.lbg)
            
            xlabel('Time [h]')
            ylabel('Room temperature [degC]')
            title('State')
            legend(solver)
            hold off
            
            dt = datetime('now');
            DateString = datestr(dt,'yyyymmddHHMMssFFF');
            
            saveas(gcf, append('.\result\', ext, '\', titleName, '_', DateString, '.', ext));
        end
    end

end