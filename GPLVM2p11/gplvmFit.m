function model = gplvmFit(Y, dims, options, kernelType, noiseType, ...
                          selectionCriterion, numActive, lbls)

% GPLVMFIT Fit a Gaussian process latent variable model.
%
%	Description:
%	model = gplvmFit(Y, dims, options, kernelType, noiseType, ...
%                          selectionCriterion, numActive, lbls)
%% 	gplvmFit.m CVS version 1.7
% 	gplvmFit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

if nargin < 8
  lbls = [];
end


model = gplvmInit(Y, dims, options, kernelType, noiseType, selectionCriterion, numActive);
model = gplvmOptimise(model, options, lbls);
