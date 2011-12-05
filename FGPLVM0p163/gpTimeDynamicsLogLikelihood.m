function ll = gpTimeDynamicsLogLikelihood(model)

% GPTIMEDYNAMICSLOGLIKELIHOOD Give the log likelihood of GP time dynamics.
%
%	Description:
%
%	LL = GPTIMEDYNAMICSLOGLIKELIHOOD(MODEL) Computes the log likelihood
%	of GP time dynamics in a GP-LVM model.
%	 Returns:
%	  LL - the log likelihood of the data in the GP model.
%	 Arguments:
%	  MODEL - the GP model for which log likelihood is to be computed.
%	
%	
%	
%
%	See also
%	GPTIMEDYNAMICSCREATE, GPTIMEDYNAMICSLOGLIKEGRADIENTS, MODELLOGLIKELIHOOD


%	Copyright (c) 2006 Neil D. Lawrence


%	With modifications by Carl Henrik Ek 2008
% 	gpTimeDynamicsLogLikelihood.m CVS version 1.1
% 	gpTimeDynamicsLogLikelihood.m SVN version 82
% 	last update 2008-09-12T09:31:42.000000Z

ll = gpLogLikelihood(model);

