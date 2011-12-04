function g = gplvmActiveSetGradient(xVals, model, prior)

% GPLVMACTIVESETGRADIENT Wrapper function for calling gradient for active set positions.
%
%	Description:
%	g = gplvmActiveSetGradient(xVals, model, prior)
%% 	gplvmActiveSetGradient.m CVS version 1.3
% 	gplvmActiveSetGradient.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
g = gplvmApproxLogLikeActiveSetGrad(model);

% check if there is a prior over active set positions.
if nargin > 2 & ~isempty(prior)
  g = g + priorGradient(prior, xVals);
end

g = -g;

