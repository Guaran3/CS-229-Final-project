
% DEMLINEARORDINAL1 Model the twos data with a 2-D RBF GPLVM with binomial noise.
%
%	Description:
%	% 	demLinearOrdinal1.m SVN version 326
% 	last update 2009-04-17T21:37:21.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'twos';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);
Y = Y(1:300, :);
a = rand(size(Y))<0.05;
Y(find(a)) = NaN;
% Set IVM active set size and iteration numbers.
options = gplvmOptions;
options.gplvmKern = true;
options.pointIters = 0;
options.extIters = 3;
options.display=1;
numActive = 300;

% Fit the GP latent variable model
noiseType = 'ordered';
selectionCriterion = 'random';
kernelType = {'lin', 'bias', 'white'};
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
