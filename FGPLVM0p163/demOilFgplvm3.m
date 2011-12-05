
% DEMOILFGPLVM3 Oil data with deterministic training conditional.
%
%	Description:
%	% 	demOilFgplvm3.m SVN version 544
% 	last update 2009-10-06T16:32:32.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 3;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
options = fgplvmOptions('dtc');
options.optimiser = 'scg';
latentDim = 2;
d = size(Y, 2);

model = fgplvmCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 1000;
display = 1;

model = fgplvmOptimise(model, display, iters);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
end


% Load the results and display dynamically.
lvmResultsDynamic(model.type, dataSetName, experimentNo, 'vector')

% compute the nearest neighbours errors in latent space.
errors = lvmNearestNeighbour(model, lbls);
