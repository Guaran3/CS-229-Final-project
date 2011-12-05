
% DEMVOWELSFGPLVM2 Model the vowels data with a 2-D FGPLVM using RBF kernel.
%
%	Description:
%	% 	demVowelsFgplvm2.m SVN version 536
% 	last update 2009-09-29T21:27:49.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'vowels';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
options = fgplvmOptions('fitc');
options.numActive = 200;
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
lvmResultsDynamic(dataSetName, experimentNo, 'vector')

errors = lvmNearestNeighbour(model, lbls);
