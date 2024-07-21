function n_constraint = saveConstraint(setsObj, modelObj, Nh, dirpath, solvername, options)

     %{
     Function: saveConstraintAdf
         Save the constraints of the optimization problem and their gradients and Hessian matrices as functions of the decision variables to a file

     Arguments: 
          setsObj (object)  : Instance of Settings class
          modelObj (object) : Instance of Model class
          Nh                : horizon length
          dirpath           : Path of result directory
          option (struct)   : Option

     Return:
          n_constraint : The number of constraints

     Output:
          Output file names:
          - constraint_Nh[Nh]_[solvername].m
          - constraintHess_Nh[Nh]_[solvername]_[idx].m
          where:
            [Nh]: value of the Nh argument
            [solvername]: name of the solver passed as an argument
            [idx]: index (which constraint the Hessian matrix corresponds to)
     %}

     import myParallelSMPC.Solver

     switch nargin
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

     modelObj.augmentModelMatrix(Nh);

     n = modelObj.n;
     m = modelObj.m;
     r = modelObj.r;
     p = modelObj.p;

     n_M = round(Nh*(Nh-1)*m*r/2);
     n_h = Nh*m;

     % constraints
     lbg_x  = sym(zeros((Nh+1)*p, 1));
     lbg_u = sym(zeros(Nh*m, 1));
     ubg_u = sym(zeros(Nh*m, 1));
     %% calculate fai_inverse(1-alpha)
     fainv_x = norminv(1-setsObj.alpha_x);
     fainv_u = norminv(1-setsObj.alpha_u);

     switch solvername
     case "Adf"
          %{
          Solver: SOCP with ADF
               x(t) -> u(t)

          Symbolic variables
               Decision variables: M, h
               Problem Parameters
                    x0 : x(t)
          %}
          
          % Decision variables
          M_vec = sym('M', [1 n_M], 'real').';
          h = sym('h', [1 n_h], 'real').';
          decVars = [M_vec; h];

          M = Solver.vec2mat_M_sym(M_vec, Nh, m, r);

          % Parameters
          x0 = sym('x0', [1 n], 'real').';
          probParams = x0;

          % Constraints
          for i = p+1 : (Nh+1)*p
               lbg_x(i) = modelObj.exp_x(i, x0, h) - fainv_x * modelObj.dist_x(i, M) - setsObj.bound(2, 1);
          end
          
          for i = 1 : Nh*m
               lbg_u(i) = modelObj.exp_u(i, h) - fainv_u * modelObj.dist_u(i, M) - setsObj.bound(1, 1); %% lower bound
               ubg_u(i) = modelObj.exp_u(i, h) + fainv_u * modelObj.dist_u(i, M) - setsObj.bound(1, 2); %% upper bound
          end

     case "AdfTime"
          %{
          Solver: SOCP with ADF considering calculation time
               x(t) -> u(t+n_delay)

          Symbolic variables
               Decision variables: M, h
               Problem Parameters
                    x0 : x(t)
                    M_pre, h_pre : M, h that was used for u(t)
          %}

          % Decision variables
          M_vec = sym('M', [1 n_M], 'real').';
          h = sym('h', [1 n_h], 'real').';
          decVars = [M_vec; h];

          M = Solver.vec2mat_M_sym(M_vec, Nh, m, r);

          % Parameters
          x0 = sym('x0', [1 n], 'real').';
          M_vec_pre = sym('M_pre', [1 n_M], 'real').';
          h_pre = sym('h_pre', [1 n_h], 'real').';
          probParams = [x0; M_vec_pre; h_pre];

          M_pre = Solver.vec2mat_M_sym(M_vec_pre, Nh, m, r);

          % Constraints
          n_delay = getfield(options, "n_delay");
          h_k = h_pre(1:n_delay);
          x0_prob = modelObj.predictState(x0, h_k);

          for i = p+1 : (Nh+1)*p
               lbg_x(i) = modelObj.exp_x(i, x0_prob, h) - fainv_x * modelObj.dist_x_modJP(i, M, n_delay, M_pre) - setsObj.bound(2, 1);
          end

          for i = 1 : Nh*m
               lbg_u(i) = modelObj.exp_u(i, h) - fainv_u * modelObj.dist_u(i, M) - setsObj.bound(1, 1); %% lower bound
               ubg_u(i) = modelObj.exp_u(i, h) + fainv_u * modelObj.dist_u(i, M) - setsObj.bound(1, 2); %% upper bound
          end

     case "AdfPartTime"
          %{
          Solver: partial problem of SOCP with ADF considering calculation time
               x(t) -> u(t+1)

          Symbolic variables
               Decision variables: h
               Problem Parameters
                    x0 : x(t)
                    u0 : u(t)
                    M_given : given M
          %}
          
          % Decision variables
          h = sym('h', [1 n_h], 'real').';
          decVars = h;

          % Parameters
          x0 = sym('x0', [1 n], 'real').';
          u0 = sym('u0', 'real');
          M_given_vec = sym('M_given_vec', [1 n_M], 'real').';
          probParams = [x0; u0; M_given_vec];

          M_given = Solver.vec2mat_M_sym(M_given_vec, Nh, m, r);

          % Constraints
          x0_prob = modelObj.predictState(x0, u0);

          for i = p+1 : (Nh+1)*p
               lbg_x(i) = modelObj.exp_x(i, x0_prob, h) - fainv_x * modelObj.dist_x_modJP(i, M_given) - setsObj.bound(2, 1);
          end
          
          for i = 1 : Nh*m
               lbg_u(i) = modelObj.exp_u(i, h) - fainv_u * modelObj.dist_u(i, M_given) - setsObj.bound(1, 1); %% lower bound
               ubg_u(i) = modelObj.exp_u(i, h) + fainv_u * modelObj.dist_u(i, M_given) - setsObj.bound(1, 2); %% upper bound
          end

     end

     g = [-lbg_x(p+1:end); -lbg_u; ubg_u];

     vars = [decVars; probParams];

     % Compute Jacobian and Hessian of constraint 
     gJacob_T = jacobian(g, decVars).'; % .' performs transpose

     n_constraint = length(g);

     gHess = cell(1, n_constraint);
     for i = 1:n_constraint
          gHess{i} = jacobian(gJacob_T(:,i), decVars);
     end  
          
     % Save
     currdir = append(dirpath, filesep);
     filename = append("constraint_", idname, ".m");
     filepath = append(currdir, filename);
     matlabFunction(g,[], gJacob_T,[], 'file',filepath, 'vars',{vars},...
     'outputs',{'c','ceq','gradc','gradceq'});
     disp(["created ", filename])

     for i = 1:length(gHess)
          filename = append("constraintHess_", idname, "_", num2str(i), ".m");
          filepath = append(currdir, filename);
          matlabFunction(gHess{i},'file', filepath, 'vars',{vars});
          disp(["created ", filename])
     end