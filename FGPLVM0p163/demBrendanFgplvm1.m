
% DEMBRENDANFGPLVM1 Use the GP-LVM to model the Frey face data with FITC.
%
%	Description:
%	% 	demBrendanFgplvm1.m SVN version 545
% 	last update 2009-10-07T15:26:30.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'brendan';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
options = fgplvmOptions('fitc');
%options.optimiser = 'conjgrad';

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
lvmResultsDynamic(model.type, dataSetName, experimentNo, 'image', [20 28], 1, 0, 1)
