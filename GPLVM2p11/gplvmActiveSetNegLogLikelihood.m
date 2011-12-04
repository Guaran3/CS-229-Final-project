function e = gplvmActiveSetNegLogLikelihood(xVals, y, model, prior)

% GPLVMACTIVESETNEGLOGLIKELIHOOD Wrapper function for calling noise likelihoods.
%
%	Description:
%	e = gplvmActiveSetNegLogLikelihood(xVals, y, model, prior)
%% 	gplvmActiveSetNegLogLikelihood.m CVS version 1.4
% 	gplvmActiveSetNegLogLikelihood.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z
model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
L = ivmApproxLogLikelihood(model);

% check if there is a prior over kernel parameters
if nargin > 3 & ~isempty(prior)
  for i = model.I
    L = L + priorLogProb(prior, model.X(i, :));
  end
end
e = -L;
