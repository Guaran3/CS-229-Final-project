
% DEMSWISSROLL2 Model the face data with a 2-D GPLVM initialised with isomap.
%
%	Description:
%	% 	demSwissRoll2.m CVS version 1.2
% 	demSwissRoll2.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'swissRoll';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
numActive = 100;
options.initX = 'isomap';

% Fit the GP latent variable model
noiseType = 'gaussian';
selectionCriterion = 'entropy';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmFit(Y, 2, options, kernelType, noiseType, selectionCriterion, numActive, lbls);

% Save the results.
[X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load results and display dynamically.
gplvmScatterPlotColor(model, model.y(:, 2));