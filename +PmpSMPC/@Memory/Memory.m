classdef Memory < handle

    properties 
        FutureAdfList_M
        FutureAdfPartList_h
        TimeData
        defaultMh % array (n_thread, n_M+n_h, 1)
    end

    methods
        function obj = Memory(setsObj, isDubug)
            options = setsObj.options;
            n_thread = options.n_thread;

            % pre-allocation            
            FutureAdfList_M(1, setsObj.Nt - n_thread) = parallel.FevalFuture(); 
            FutureAdfPartList_h(1, setsObj.Nt - n_thread) = parallel.FevalFuture(); 

            obj.TimeData = struct;
            obj.FutureAdfList_M = FutureAdfList_M;
            obj.FutureAdfPartList_h = FutureAdfPartList_h;
        end

        function setDefaultMh(obj, Mh)

            obj.defaultMh = Mh;
        end

        % Store the 'data' in the 'TimeData' structure property under the field name 'dataTitle'
        function addTimeData(obj, data, dataTitle)

            if isfield(obj.TimeData, dataTitle)
                obj.TimeData.(dataTitle) = [obj.TimeData.(dataTitle), data];
            else
                obj.TimeData.(dataTitle) = [data];
            end
        end

        function addFutureAdf_M(obj, f, idx)

            obj.FutureAdfList_M(idx) = f;
        end

        function addFutureAdfPart_h(obj, f, idx)

            obj.FutureAdfPartList_h(idx) = f;
        end
    end
end