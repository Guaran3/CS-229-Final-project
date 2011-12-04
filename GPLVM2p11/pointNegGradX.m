function g = pointNegGradX(x, y, model, prior)

% POINTNEGGRADX Wrapper function for calling noise gradients.
%
%	Description:
%	g = pointNegGradX(x, y, model, prior)
%% 	pointNegGradX.m CVS version 1.4
% 	pointNegGradX.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

g = ivmGradX(model, x, y);
% check if there is a prior over kernel parameters
if nargin > 3 & ~isempty(prior)
  g = g + priorGradient(prior, x);
end

g = -g;
