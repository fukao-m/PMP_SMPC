function callbackAdf(~, ~, p, t, systemObj, setsObj, memoObj)

    options = setsObj.options;
    n_thread = options.n_thread;

    processIdx = t.TasksExecuted;
    threadIdx = rem(processIdx-1, n_thread) + 1; % 1, 2, 3, 4, 1, 2, 3, 4, ... ( when n_thread is 4)

    systemObj.measureTime("startOnlineSMPC", "startCallbackAdf", processIdx);
    
    N = setsObj.Nh;
    m = setsObj.m;
    r = setsObj.r;

    n_M = round(N*(N-1)*m*r/2);
    n_h = N*m;

    if processIdx <= n_thread
        defaultMh = memoObj.defaultMh;
        inputMh = reshape(defaultMh(threadIdx, :, :), n_M+n_h, 1);

        M_vec_pre = inputMh(1:n_M, :);
        h_pre     = inputMh(n_M+1:n_M+n_h, :);

    else
        % get the results of previous process in the same thread 
        f_Adf     = memoObj.FutureAdfList_M(    processIdx - n_thread);
        f_AdfPart = memoObj.FutureAdfPartList_h(processIdx - n_thread);
        systemObj.measureTime("startOnlineSMPC", "adfGotAdfResult",     processIdx);
        try
            M_vec_pre = fetchOutputs(f_Adf);
        catch 
            disp(append("can't fetch output of Adf on process", num2str(processIdx)))
        end

        systemObj.measureTime("startOnlineSMPC", "adfGotAdfPartResult", processIdx);
        try
            h_pre     = fetchOutputs(f_AdfPart);
        catch 
            disp(append("can't fetch output of AdfPart on process", num2str(processIdx)))
        end
    end

    % predict the future states by using h0
    x0 = systemObj.getStateAt(processIdx);

    % parfeval
    systemObj.measureTime("startOnlineSMPC", "startAdf", processIdx);
    f = parfeval(p, @socp_adf_modJP, 1, x0, N, m, r, M_vec_pre, h_pre, n_thread-1);

    % store FevalFuture in the Memory object
    memoObj.addFutureAdf_M(f, processIdx);
    
    systemObj.measureTime("startOnlineSMPC", "endCallbackAdf", processIdx);
   
end

function M_vec = socp_adf_modJP(x0, N, m, r, M_vec_pre, h_pre, n_delay)

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

    idname = makeIdName_AdfTime(N, struct("n_delay", n_delay));

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

function idname = makeIdName_AdfTime(Nh, options)
    %{
    Function makeIdName_AdfTime:
        Name uniquely based on each condition. For AdfTime.

    Input
        Nh                : Horizon length
        option (struct)   : Option

    Output
        idname (string)   : ID name
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