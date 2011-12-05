function prior = invgammaPriorParamInit(prior)

% INVGAMMAPRIORPARAMINIT Inverse gamma prior model's parameter initialisation.
%
%	Description:
%
%	PRIOR = INVGAMMAPRIORPARAMINIT(PRIOR) initialises the parameters of
%	the inverse gamma prior with some default parameters.
%	 Returns:
%	  PRIOR - prior structure with initial values in place.
%	 Arguments:
%	  PRIOR - prior structure to be initialised.
%	
%
%	See also
%	PRIORCREATE, GAMMAPRIORPARAMINIT


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	invgammaPriorParamInit.m CVS version 1.3
% 	invgammaPriorParamInit.m SVN version 29
% 	last update 2007-11-03T14:22:18.000000Z


prior.a = 1e-6;
prior.b = 1e-6;

prior.transforms.index = [1 2];
prior.transforms.type =  optimiDefaultConstraint('positive');
prior.nParams = 2;
