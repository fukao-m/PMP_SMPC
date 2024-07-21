function newdirpath = makeSymbolicProblem(modelObj, setsObj, Nh, dirpath, solvername, options)

    %{
        Function: makeSymbolicProblem
            Define the problem (objective function, constraints, and their gradients and Hessian matrices) using symbolic variables
        
        Argument:
            modelObj         : Instance of Model class
            setsObj          : Instance of Settings class
            Nh      (int)    : Horizon length
            dirpath (str)    : Path to save files for each problem
            solvername (str) : Solver's name
            option (struct)  : Option

        Return:
            newdirpath : Path of the directory where the problem definition was created
    %}
    import myParallelSMPC.Solver

    switch nargin
        case 2
            Nh = setsObj.Nh;
            dirpath = pwd;
            solvername = "AdfTime";
            options = struct;
        case 3
            dirpath = pwd;
            solvername = "AdfTime";
            options = struct;
        case 4 
            solvername = "AdfTime";
            options = struct;
        case 5 
            options = struct;
    end

    idname = Solver.makeIdName(solvername, Nh, options);

    dirname = append("problem_", idname);
    newdirpath = append(dirpath, filesep, dirname);
    [~,msg,msgID] = mkdir(newdirpath);
    
    if length(msgID) > 0
        if msgID=='MATLAB:MKDIR:DirectoryExists'
            disp('The symbolic problem has already been created')
        else
            disp(msg)
        end
        
    else
        %% Objective function
        Solver.saveObjectiveFunc(modelObj, Nh, newdirpath, solvername, options);
        
        %% Constraint
        n_constraint = Solver.saveConstraint(setsObj, modelObj, Nh, newdirpath, solvername, options);
        
        %% Hessian of Lagrange function
        Solver.saveLagrangeHess(n_constraint, Nh, newdirpath, solvername, options);
    end

end