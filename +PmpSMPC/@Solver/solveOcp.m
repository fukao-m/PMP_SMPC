function optimalDecVars = solveOcp(solvername, Nh, initDecVars, probParamsObjective, probParamsConstr, options)


    switch nargin
    case 5
        options = struct;
        
    end

    import myParallelSMPC.Solver

    idname = Solver.makeIdName(solvername, Nh, options);

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
    [optimalDecVars, ~,~,~] = fmincon(objective, initDecVars,...
        [],[],[],[],[],[],constraint, options);

end