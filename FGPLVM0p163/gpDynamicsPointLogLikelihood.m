function ll = gpDynamicsPointLogLikelihood(model, x, y)

% GPDYNAMICSPOINTLOGLIKELIHOOD Compute the log likelihood of a point under the GP dynamics model.
%
%	Description:
%	DESC computes the log likelihood of a given point under the GP
%	dynamics model.
%	ARG model : the model for which the log likelihood is to be
%	computed.
%	ARG x : the input location for the model.
%	ARG y : the target location for the model.
%	RETURN ll : the log likelihood of the given point.
%	
%	
%	
%
%	See also
%	GPDYNAMICSCREATE, GPDYNAMICSLOGLIKELIHOOD, GPPOINTLOGLIKELIHOOD


%	Copyright (c) 2006 Neil D. Lawrence
% 	gpDynamicsPointLogLikelihood.m CVS version 1.1
% 	gpDynamicsPointLogLikelihood.m SVN version 761
% 	last update 2010-04-13T14:06:03.000000Z
% MODIFICATION: Carl Henrik Ek, 2009


if(isfield(model,'indexIn'))
  x = x(:,model.indexIn);
  y = y(:,model.indexIn);
end
ll = gpPointLogLikelihood(model, x, y);