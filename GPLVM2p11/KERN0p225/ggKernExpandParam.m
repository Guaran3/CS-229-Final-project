function kern = ggKernExpandParam(kern, params)

% GGKERNEXPANDPARAM Create kernel structure from GG kernel's parameters.
%
%	Description:
%
%	KERN = GGKERNEXPANDPARAM(KERN, PARAM) returns a gaussian gaussian
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
%
%	See also
%	GGKERNPARAMINIT, GGKERNEXTRACTPARAM, KERNEXPANDPARAM


%	Copyright (c) 2008 Mauricio A. Alvarez and Neil D. Lawrence


%	With modifications by Mauricio A. Alvarez 2009
% 	ggKernExpandParam.m SVN version 426
% 	last update 2009-07-17T10:58:29.000000Z

sizeP = size(kern.precisionU,1);
kern.precisionU = params(1:sizeP)';
kern.precisionG = params(sizeP+1:2*sizeP)';
kern.sigma2Latent = params(end-1);
kern.sensitivity = params(end);
