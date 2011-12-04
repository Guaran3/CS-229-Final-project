function e = pointApproxNegLogLikelihood(x, m, beta, model, prior)

% POINTAPPROXNEGLOGLIKELIHOOD Wrapper function for calling likelihoods.
%
%	Description:
%	e = pointApproxNegLogLikelihood(x, m, beta, model, prior)
%% 	pointApproxNegLogLikelihood.m CVS version 1.3
% 	pointApproxNegLogLikelihood.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

L = ivmApproxLogLikelihood(model, x, m, beta);

% check if there is a prior over kernel parameters
if nargin > 3
  L = L + priorLogProb(prior, x(prior.index));
end
e = -L;
