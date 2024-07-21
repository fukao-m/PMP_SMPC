function saveObjectiveFunc(modelObj, Nh, dirpath, solvername, options)
     
     %{
     Function: saveObjectiveFunc
          Save the objective function of the optimization problem,
          its gradient, and Hessian matrix as functions of decision variables to files

     Arguments: 
          modelObj (object) : Instance of Model class
          Nh                : Horizon length
          dirpath           : Path of output
          solvername (str)  : Solver's name
          option (struct)   : Option

     Output:
          Output file names:
          - objective_Nh[Nh]_[solvername].m
          - objectiveHess_Nh[Nh]_[solvername].m
          where:
            [Nh]: value of the Nh argument
            [solvername]: name of the solver passed as an argument
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

     modelObj.augmentModelMatrix(Nh);

     n = modelObj.n;
     m = modelObj.m;
     r = modelObj.r;

     n_M = round(Nh*(Nh-1)*m*r/2);
     n_h = Nh*m;

     switch solvername
     case "Adf"
          %{
          Solver: SOCP with ADF
               x(t) -> u(t)

          Symbolic variables
               Decision variables: M, h
               Problem Parameters
                    x0 : x(t) (time t is time you started solving the OCP)
          %}

          % Decision variables
          M_vec = sym('M', [1 n_M], 'real').';
          h = sym('h', [1 n_h], 'real').';
          Mh_vec = [M_vec; h];
          decVars = Mh_vec;

          M = Solver.vec2mat_M_sym(M_vec, Nh, m, r);

          % Parameters
          x0 = sym('x0', [1 n], 'real').';
          probParams = x0;

          % Constraints
          objective = modelObj.J_adf_sym(x0, M, h);

     case "AdfTime"
          %{
          Solver: SOCP with ADF considering calculation time
               x(t) -> u(t+n_delay)

          Symbolic variables
               Decision variables: M, h
               Problem Parameters
                    x0 : x(t) (time t is time you started solving the OCP)
                    M_pre, h_pre : optimal variables M, h used to calculate u(t)
          %}

          % Decision variables
          M_vec = sym('M', [1 n_M], 'real').';
          h = sym('h', [1 n_h], 'real').';
          Mh_vec = [M_vec; h];
          decVars = Mh_vec;

          M = Solver.vec2mat_M_sym(M_vec, Nh, m, r);

          % Parameters
          x0 = sym('x0', [1 n], 'real').';
          h_pre = sym('h_pre', [1 n_h], 'real').';
          probParams = [x0; h_pre];

          % Constraints
          n_delay = getfield(options, "n_delay");
          h_k = h_pre(1:n_delay);
          x0_prob = modelObj.predictState(x0, h_k);
          objective = modelObj.J_adf_sym(x0_prob, M, h);

     case "AdfPartTime"
          %{
          Solver: partial problem of SOCP with ADF considering calculation time
               x(t) -> u(t+1)

          Symbolic variables
               Decision variables: h
               Problem Parameters
                    x0 : x(t)
                    u0 : u(t)
          %}

          % Decision variables
          h = sym('h', [1 n_h], 'real').';
          decVars = h;

          % Parameters
          x0 = sym('x0', [1 n], 'real').';
          u0 = sym('u0', 'real');
          probParams = [x0; u0];

          % Constraints
          x0_prob = modelObj.predictState(x0, u0);
          objective = modelObj.J_adf_h_sym(x0_prob, h);

     end

     % Compute Jacobian and Hessian of objective function
     objectiveJacob_T = jacobian(objective, decVars).';
     objectiveHess = jacobian(objectiveJacob_T, decVars);
     
     vars = [decVars; probParams];

     % Save
     currdir = append(dirpath, filesep);
     filename = append("objective_", idname, ".m");
     filepath = append(currdir, filename);
     matlabFunction(objective,objectiveJacob_T, 'file', filepath, 'vars',{vars});
     disp(["created ", filename])

     filename = append("objectiveHess_", idname, ".m");
     filepath = append(currdir, filename);
     matlabFunction(objectiveHess, 'file', filepath, 'vars',{vars});
     disp(["created ", filename])

end