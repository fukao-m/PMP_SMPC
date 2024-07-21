function callbackAdfPart(~, ~, p, t, systemObj, setsObj, memoObj)
    % This function has two roles: 
    % 1. Receive the previous result and use it to calculate the input for the next time step.
    % 2. Store the received previous result.

    options = setsObj.options;
    n_thread = options.n_thread;

    processIdx = t.TasksExecuted;
    threadIdx = rem(processIdx-1, n_thread) + 1; % 1, 2, 3, 4, 1, 2, 3, 4, ... ( when n_thread is 4)
    
    systemObj.measureTime("startOnlineSMPC", "startCallbackAdfPart", processIdx);
    
    N = setsObj.Nh;
    m = setsObj.m;

    if processIdx == 1
        u_pre = systemObj.getInputAt(n_thread);
        
    elseif processIdx == (setsObj.Nt - n_thread + 1)
        % For receiving the final calculation result
        f = memoObj.FutureAdfPartList_h(processIdx - 1);
        systemObj.measureTime("startOnlineSMPC", "adfPartGotAdfPartResult", processIdx);
        try
            h0 = fetchOutputs(f);
        catch 
            disp(append("can't fetch output of AdfPart on process", num2str(processIdx)))
        end

        u_opt = h0(1);
        systemObj.setInput(u_opt, processIdx + n_thread - 1);
        return;
        
    else
        f = memoObj.FutureAdfPartList_h(processIdx - 1);
        systemObj.measureTime("startOnlineSMPC", "adfPartGotAdfPartResult", processIdx);
        try
            h0 = fetchOutputs(f);
        catch 
            disp(append("can't fetch output of AdfPart on process", num2str(processIdx)))
        end

        u_pre = h0(1:m, 1);
        systemObj.setInput(u_pre, processIdx + n_thread - 1);
    end

    systemObj.measureTime("startOnlineSMPC", "adfPartGotAdfResult", processIdx);
    future_M = memoObj.FutureAdfList_M(processIdx);
    try
        M_given_vec = fetchOutputs(future_M);
    catch 
        disp(append("can't fetch output of Adf on process", num2str(processIdx)))
    end

    x0 = systemObj.getStateAt(processIdx + n_thread - 1);

    systemObj.measureTime("startOnlineSMPC", "startAdfPart", processIdx);
    f = parfeval(p, @sub_h_modJP, 1, x0, N, m, M_given_vec, u_pre);

    % store FevalFuture in the Memory instance
    memoObj.addFutureAdfPart_h(f, processIdx);
    
    systemObj.measureTime("startOnlineSMPC", "endCallbackAdfPart", processIdx);

end

function h_opt = sub_h_modJP(x0, N, m, M_given_vec, u_pre)

    n_h = N*m;

    % coldstart
    h0 = repmat(10.0, n_h, 1);

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

    probParamsObjective = [x0; u_pre];
    probParamsConstr    = [x0; u_pre; M_given_vec];

    idname = append("AdfPartTime", "_Nh", num2str(N));

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
    [optimalDecVars, ~,~,~] = fmincon(objective, h0,...
        [],[],[],[],[],[],constraint, options);

    h_opt = optimalDecVars;
    
end