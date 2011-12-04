function f = gplvmKernelObjective(params, model, prior)

% GPLVMKERNELOBJECTIVE Likelihood approximation.
%
%	Description:
%	f = gplvmKernelObjective(params, model, prior)
%% 	gplvmKernelObjective.m CVS version 1.1
% 	gplvmKernelObjective.m SVN version 326
% 	last update 2009-04-17T21:41:38.000000Z

xVals = params(model.kern.nParams+1:end);

model.kern = kernExpandParam(model.kern, params(1:model.kern.nParams));
model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
L = ivmApproxLogLikelihood(model);

% check if there is a prior over active set positions.
L = L + kernPriorLogProb(model.kern);
if nargin > 2 && ~isempty(prior)
  L = L + priorLogProb(prior, xVals);
end
f = -L;
