
% DEMOILFGPLVM9 Oil data with three dimensions and variational sparse approximation.
%
%	Description:
%	% 	demOilFgplvm9.m SVN version 545
% 	last update 2009-10-07T16:23:54.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 9;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
options = fgplvmOptions('dtcvar');
options.kern = {'rbf', 'bias', 'whitefixed'};
options.optimiser = 'scg';
latentDim = 3;
d = size(Y, 2);

model = fgplvmCreate(latentDim, d, Y, options);
model.kern.comp{3}.variance = 1e-4;
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
errors = fgplvmNearestNeighbour(model, lbls);
