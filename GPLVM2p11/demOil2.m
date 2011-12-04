
% DEMOIL2 Model the oil data with a 2-D GPLVM using MLP kernel.
%
%	Description:
%	% 	demOil2.m CVS version 1.9
% 	demOil2.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
numActive = 100;

% Initialise X with PCA.
X = gplvmPcaInit(Y, 2);

% Plot the intialisation.
symbols = getSymbols(3);
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbols{labelNo})
end

% Fit the GP latent variable model
noiseType = 'gaussian';
selectionCriterion = 'entropy';
kernelType = {'mlp', 'bias', 'white'};
model = gplvmFit(Y, 2, options, kernelType, noiseType, selectionCriterion, numActive, lbls);


% Save the results.
[X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'vector')

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector')

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')
