clear
import PmpSMPC.*

solver = ["Proposed method"]; % ["smpc_adf", "Proposed method"];
titleName = "smpc_adf";
bPlot = true;

config = './config/Nh10T150.json';
setsObj = Settings(config);
modelObj = Model(config);

% define noise 
% r = size(E,2);
% noise = randn(Nt, r);
noise = readmatrix('./data/noise.csv');

% define a systemobj instance
systemObj = System(setsObj, modelObj, noise);

% define the optimization problem
sol = Solver(setsObj, modelObj, systemObj, config);

% solve
results = sol.solve(solver);
timeData = sol.getTimeData();

% plot
if bPlot
     % set a Plotter object
     plotterobj = Plotter(setsObj);

     plotterobj.plot(results, solver, titleName, "png");
     plotterobj.plot(results, solver, titleName, "pdf");
end

