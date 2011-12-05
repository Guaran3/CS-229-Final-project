function kern = whitefixedKernParamInit(kern)

% WHITEFIXEDKERNPARAMINIT WHITEFIXED kernel parameter initialisation.
%
%	Description:
%	The white noise kernel arises from assuming independent Gaussian
%	noise for each point in the function. The variance of the noise is
%	given by the kern.variance parameter. The fixed white noise kernel
%	is a simple variant of the white kernel that doesn't allow the noise
%	parameter to be optimised. It is useful when the level of noise is
%	known a priori.
%	
%	This kernel is not intended to be used independently, it is provided
%	so that it may be combined with other kernels in a compound
%	kernel.
%	
%	
%
%	KERN = WHITEFIXEDKERNPARAMINIT(KERN) initialises the fixed parameter
%	white noise kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	CMPNDKERNPARAMINIT, KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2006 Nathaniel J. King
% 	whitefixedKernParamInit.m CVS version 1.5
% 	whitefixedKernParamInit.m SVN version 151
% 	last update 2008-11-06T10:11:56.000000Z

kern.variance = exp(-2);
kern.nParams = 0;

kern.isStationary = true;
