function g = dnetOutputGradX(model, X)

% DNETOUTPUTGRADX Evaluate derivatives of DNET model outputs with respect to inputs.
%
%	Description:
%
%	G = DNETOUTPUTGRADX(MODEL, X) returns the derivatives of the outputs
%	of an DNET model with respect to the inputs to the model.
%	 Returns:
%	  G - the gradient of the output with respect to the inputs.
%	 Arguments:
%	  MODEL - the model for which the derivatives will be computed.
%	  X - the locations at which the derivatives will be computed.
%	
%
%	See also
%	DNETOUTPUTGRAD, MODELOUTPUTGRADX


%	Copyright (c) 2008 Neil D. Lawrence
% 	dnetOutputGradX.m SVN version 24
% 	last update 2008-06-16T14:58:05.000000Z

g = modelOutputGradX(model.mapping, X);
