function saveLagrangeHess(n_constr, Nh, dirpath, solvername, options)
    %{
    
    Function: saveLagrangeHess
        Create a file for the Hessian matrix of the Lagrangian function
        from the files of Hessian matrices of the objective function and constraints.

    Arguments: 
        n_constr : The number of constraints
        dirpath  : Path of output
        option (struct) : Option
    %}
    
    import myParallelSMPC.Solver

    switch nargin
        case 2
            dirpath = pwd;
            solvername = "AdfTime";
            options = struct;
        case 3
            solvername = "AdfTime";
            options = struct;
        case 4
            options = struct;
    end

    idname = Solver.makeIdName(solvername, Nh, options);

    filename = append("LagrangeHess_", idname, ".m");
    filepath = append(dirpath, filesep, filename);

    fid = fopen(filepath, "wt");
    
    content(1)  = append("function LHess = LagrangeHess_", idname, "(decVars, probParamsObjective, probParamsConstr, lambda)");
    content(2)  = "    %%{";
    content(3)  = append("        Function: LagrangeHess_", idname);
    content(4)  = "            Function that returns the Hessian matrix of the Lagrangian function";
    content(4)  = append("            Solver type is ", solvername);
    content(5)  = "        Arguments: ";
    content(6)  = "             decVars    : Decision variables";
    content(7)  = "             probParamsObjective : Parameters of objective function";
    content(8)  = "             probParamsConstr : Parameters of constraint";
    content(9)  = "             lambda     : Lagrange variables";
    content(10)  = "    %%}";
    content(11)  = "";
    content(12)  = "    varsObjective = [decVars; probParamsObjective];";
    content(13)  = "    varsConstr    = [decVars; probParamsConstr];";
    content(14)  = "";
    content(15)  = "";
    content(16) = append("    objectiveHess = objectiveHess_", idname, "(varsObjective);");
    content(17)  = "";
    content(18) = "    %% Add the Lagrange multipliers * the constraint Hessians";
    content(19) = "    LHess = objectiveHess;";

    startForIdx = length(content);
    for idx = 1 : n_constr
        funcname = append("constraintHess_", idname, "_", num2str(idx));
        content(startForIdx+idx) = append("    LHess = LHess + ", funcname, "(varsConstr) * lambda.ineqnonlin(", num2str(idx), ");");
    end
    endForIdx = length(content);
    
    content(endForIdx+1) = "";
    content(endForIdx+2) = "end";

    wholeContent = "";
    for idx = 1 : length(content)
        wholeContent = append(wholeContent, content(idx), "\n");
    end
    
    fprintf(fid, wholeContent);
    fclose(fid);
    
    disp(["created ", filename])

end