
% DEMSTICKFGPLVM5 Model the stick man using an RBF kernel and regressive dynamics.
%
%	Description:
%	% 	demStickFgplvm5.m SVN version 536
% 	last update 2009-09-29T17:53:06.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 5;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
% Train using the full training conditional (i.e. no approximation.)
options = fgplvmOptions('ftc');
latentDim = 2;

d = size(Y, 2);
model = fgplvmCreate(latentDim, d, Y, options);

% Add dynamics model.
options = gpOptions('ftc');
options.kern = kernCreate(model.X, {'rbf', 'white'});
options.kern.comp{1}.inverseWidth = 0.01;
% This gives signal to noise of 0.1:1e-3 or 100:1.
options.kern.comp{1}.variance = 1;
options.kern.comp{2}.variance = 1e-3^2;
model = fgplvmAddDynamics(model, 'gpTime', options);

% Optimise the model.
iters = 1000;
display = 1;

model = fgplvmOptimise(model, display, iters);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

if exist('printDiagram') & printDiagram
  fgplvmPrintPlot(model, lbls, dataSetName, experimentNo);
end

% load connectivity matrix
[void, connect] = mocapLoadTextData('run1');
% Load the results and display dynamically.
lvmResultsDynamic(model.type, dataSetName, experimentNo, 'stick', connect)

