function e = pointNegLogLikelihood(x, y, model, prior)

% POINTNEGLOGLIKELIHOOD Wrapper function for calling noise likelihoods.
%
%	Description:
%	e = pointNegLogLikelihood(x, y, model, prior)
%% 	pointNegLogLikelihood.m CVS version 1.5
% 	pointNegLogLikelihood.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

L = ivmLogLikelihood(model, x, y);

% check if there is a prior over latent space 
if nargin > 3
  L = L + priorLogProb(prior, x);
end
e = -L;
