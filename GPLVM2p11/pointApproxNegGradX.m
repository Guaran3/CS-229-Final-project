function g = pointApproxNegGradX(x, m, beta, model, prior)

% POINTAPPROXNEGGRADX Wrapper function for calling approximate noise gradients.
%
%	Description:
%	g = pointApproxNegGradX(x, m, beta, model, prior)
%% 	pointApproxNegGradX.m CVS version 1.3
% 	pointApproxNegGradX.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

g = ivmApproxGradX(model, x, m, beta);

% check if there is a prior over kernel parameters
if nargin > 3
  g = g + priorGradient(prior, x(prior.index));
end

g = -g;
