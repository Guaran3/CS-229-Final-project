
% DEMTWOS2 Model the twos data with a 2-D RBF GPLVM with binomial noise.
%
%	Description:
%	% 	demTwos2.m CVS version 1.8
% 	demTwos2.m SVN version 29
% 	last update 2008-01-24T09:57:51.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'twos';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
options.display=1;
numActive = 100;

% Fit the GP latent variable model
noiseType = 'ordered';
selectionCriterion = 'entropy';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmFit(Y, 2, options, kernelType, noiseType, selectionCriterion, numActive, lbls);

% Save the results.
[X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'image', [8 8], 1, 1, 1)

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'image', [8 8], 1, 1, 1)

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')
