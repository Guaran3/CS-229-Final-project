function kern = rbfard2KernExpandParam(kern, params)

% RBFARD2KERNEXPANDPARAM Create kernel structure from RBFARD2 kernel's parameters.
%
%	Description:
%
%	KERN = RBFARD2KERNEXPANDPARAM(KERN, PARAM) returns a automatic
%	relevance determination radial basis function kernel structure
%	filled with the parameters in the given vector. This is used as a
%	helper function to enable parameters to be optimised in, for
%	example, the NETLAB optimisation functions.
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
%
%	See also
%	RBFARD2KERNPARAMINIT, RBFARD2KERNEXTRACTPARAM, KERNEXPANDPARAM


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
%	Copyright (c) 2009 Michalis K. Titsias
% 	rbfard2KernExpandParam.m SVN version 582
% 	last update 2009-11-08T13:06:33.000000Z

kern.variance = params(1);
kern.inputScales = params(2:end);
