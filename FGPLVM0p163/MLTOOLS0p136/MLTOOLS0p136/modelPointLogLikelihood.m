function ll = modelPointLogLikelihood(model, varargin)

% MODELPOINTLOGLIKELIHOOD Compute the log likelihood of a given point.
%
%	Description:
%
%	LL = MODELPOINTLOGLIKELIHOOD(MODEL, ...) computes the log likelihood
%	of the given model.
%	 Returns:
%	  LL - the log likelihood of the given data point.
%	 Arguments:
%	  MODEL - the model for which the log likelihood is to be computed.
%	  ... - additional arguments as required.
%	
%
%	See also
%	MODELLOGLIKELIHOOD, MODELCREATE


%	Copyright (c) 2006 Neil D. Lawrence
% 	modelPointLogLikelihood.m CVS version 1.1
% 	modelPointLogLikelihood.m SVN version 24
% 	last update 2006-12-29T09:48:36.000000Z

fhandle = str2func([model.type 'PointLogLikelihood']);
ll = fhandle(model, varargin{:});