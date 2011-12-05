function [mu, varsigma] = ppcaPosteriorMeanVar(model, X);

% PPCAPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
%
%	Description:
%
%	[MU, SIGMA] = PPCAPOSTERIORMEANVAR(MODEL, X) returns the posterior
%	mean and variance for a given set of points.
%	 Returns:
%	  MU - the mean of the posterior distribution.
%	  SIGMA - the variances of the posterior distributions.
%	 Arguments:
%	  MODEL - the model for which the posterior will be computed.
%	  X - the input positions for which the posterior will be computed.
%	
%
%	See also
%	PPCACREATE


%	Copyright (c) 2008 Neil D. Lawrence
% 	ppcaPosteriorMeanVar.m SVN version 24
% 	last update 2008-06-14T16:48:38.000000Z

[mu, phi] = ppcaOut(model, X);
%sqrt(det(phi*model.A*model.A'*phi))
% Include magnification factors here ... need derivatives of outputs ...
% modelOutputGradX ...
varsigma = repmat(1/model.beta, size(X, 1), 1);
