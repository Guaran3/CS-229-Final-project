function model = gplvmInit(Y, dims, options, kernelType, noiseType, selectionCriterion, numActive)

% GPLVMINIT Initialise a GPLVM model.
%
%	Description:
%	model = gplvmInit(Y, dims, options, kernelType, noiseType, selectionCriterion, numActive)
%% 	gplvmInit.m CVS version 1.6
% 	gplvmInit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

% Initialise X.
[X, resVariance] = gplvmInitX(Y, dims, options);

% Set up gplvm as an ivm.
model = ivm(X, Y, kernelType, noiseType, selectionCriterion, numActive);

    
  