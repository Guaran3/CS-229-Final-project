function f = dnetObjective(params, model)

% DNETOBJECTIVE Wrapper function for Density Network objective.
%
%	Description:
%
%	F = DNETOBJECTIVE(PARAMS, MODEL) provides a wrapper function for the
%	Density Network, it takes the negative of the log likelihood,
%	feeding the parameters correctly to the model.
%	 Returns:
%	  F - the negative of the log likelihood of the model.
%	 Arguments:
%	  PARAMS - the parameters of the Density Network model.
%	  MODEL - the model structure in which the parameters are to be
%	   placed.
%	
%
%	See also
%	DNETCREATE, DNETLOGLIKELIHOOD, DNETEXPANDPARAM


%	Copyright (c) 2008 Neil D. Lawrence
% 	dnetObjective.m SVN version 24
% 	last update 2008-06-18T15:38:26.000000Z

model = dnetExpandParam(model, params);
f = - dnetLogLikelihood(model);
