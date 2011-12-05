function kern = expKernExpandParam(kern, params)

% EXPKERNEXPANDPARAM Create kernel structure from EXP kernel's parameters.
%
%	Description:
%
%	KERN = EXPKERNEXPANDPARAM(KERN, PARAM) returns a exponentiated
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
%	EXPKERNPARAMINIT, EXPKERNEXTRACTPARAM, KERNEXPANDPARAM


%	Copyright (c) 2006 Neil D. Lawrence
% 	expKernExpandParam.m CVS version 1.1
% 	expKernExpandParam.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z

kern.argument = kernExpandParam(kern.argument, params(2:end));
kern.variance = params(1);
% Deal with fact that white variance is exponentiated.
if isfield(kern.argument, 'whiteVariance')
  whiteVar = kern.argument.whiteVariance;
  kern.whiteVariance = kern.variance*(exp(2*whiteVar)-exp(whiteVar));
end