function prior = wangPriorParamInit(prior)

% WANGPRIORPARAMINIT Wang prior model's parameter initialisation.
%
%	Description:
%
%	PRIOR = WANGPRIORPARAMINIT(PRIOR) initialises the parameters of the
%	prior from Jack Wang's masters thesis with some default parameters.
%	 Returns:
%	  PRIOR - prior structure with initial values in place.
%	 Arguments:
%	  PRIOR - prior structure to be initialised.
%	
%
%	See also
%	PRIORCREATE, GAMMAPRIORPARAMINIT


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	wangPriorParamInit.m CVS version 1.2
% 	wangPriorParamInit.m SVN version 29
% 	last update 2007-11-03T14:22:18.000000Z

prior.M = 1;

prior.transforms.index = [1];
prior.transforms.type = optimiDefaultConstraint('positive');
prior.nParams = 1;
