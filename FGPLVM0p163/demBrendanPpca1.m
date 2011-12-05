
% DEMBRENDANPPCA1 Use PPCA to model the Frey face data with five latent dimensions.
%
%	Description:
%	% 	demBrendanPpca1.m SVN version 802
% 	last update 2010-05-19T09:02:52.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'brendan';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set up model
options = ppcaOptions;
options.optimiser = 'scg';
latentDim = 5;
d = size(Y, 2);

model = ppcaCreate(latentDim, d, Y, options);


% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
end

% Load the results and display dynamically.
lvmResultsDynamic(model.type, dataSetName, experimentNo, 'image', [20 28], 1, 0, 1)
