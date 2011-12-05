function kern = polyardKernExpandParam(kern, params)

% POLYARDKERNEXPANDPARAM Create kernel structure from POLYARD kernel's parameters.
%
%	Description:
%
%	KERN = POLYARDKERNEXPANDPARAM(KERN, PARAM) returns a automatic
%	relevance determination polynomial kernel structure filled with the
%	parameters in the given vector. This is used as a helper function to
%	enable parameters to be optimised in, for example, the NETLAB
%	optimisation functions.
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
%	POLYARDKERNPARAMINIT, POLYARDKERNEXTRACTPARAM, KERNEXPANDPARAM


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	polyardKernExpandParam.m CVS version 1.2
% 	polyardKernExpandParam.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


kern.weightVariance = params(1);
kern.biasVariance = params(2);
kern.variance = params(3);
kern.inputScales = params(4:end);
