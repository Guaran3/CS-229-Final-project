function kern = rbfinfwhiteKernExpandParam(kern, params)

% RBFINFWHITEKERNEXPANDPARAM Create kernel structure from RBF-WHITE kernel's
%
%	Description:
%	parameters (with integration limits between minus infinity and infinity).
%
%	KERN = RBFINFWHITEKERNEXPANDPARAM(KERN, PARAM) returns a RBF-WHITE
%	kernel structure filled with the parameters in the given vector.
%	This is used as a helper function to enable parameters to be
%	optimised in, for example, the NETLAB optimisation functions.
%	 Returns:
%	  KERN - kernel structure with the given parameters in the relevant
%	   locations.
%	 Arguments:
%	  KERN - the kernel structure in which the parameters are to be
%	   placed.
%	  PARAM - vector of parameters which are to be placed in the kernel
%	   structure.
%	
%
%	See also
%	RBFINFWHITEKERNPARAMINIT, RBFINFWHITEKERNEXTRACTPARAM, KERNEXPANDPARAM


%	Copyright (c) 2009 David Luengo
% 	rbfinfwhiteKernExpandParam.m SVN version 307
% 	last update 2009-04-09T10:36:32.000000Z


kern.inverseWidth = params(1);
kern.variance = params(2);
