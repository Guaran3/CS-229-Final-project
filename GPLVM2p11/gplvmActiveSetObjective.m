function e = gplvmActiveSetObjective(xVals, model, prior)

% GPLVMACTIVESETOBJECTIVE Wrapper function for calling noise likelihoods.
%
%	Description:
%	e = gplvmActiveSetObjective(xVals, model, prior)
%% 	gplvmActiveSetObjective.m CVS version 1.3
% 	gplvmActiveSetObjective.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
L = ivmApproxLogLikelihood(model);

% check if there is a prior over active set positions.
if nargin > 2 & ~isempty(prior)
  L = L + priorLogProb(prior, xVals);
end
e = -L;
