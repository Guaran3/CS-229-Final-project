function kern = ardKernParamInit(kern)

% ARDKERNPARAMINIT ARD kernel parameter initialisation.
%
%	Description:
%	This kernel is a 'pre-packaged' compound kernel of the form
%	{'rbfard', 'linard', 'bias', 'white'}. The input scales are shared
%	between the linear and RBF ARD kernels. Using this kernel removes
%	the overhead of mutliple calls through the 'cmpnd' kernel.
%	
%	
%
%	KERN = ARDKERNPARAMINIT(KERN) initialises the pre-built RBF and
%	linear ARD kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	% SEEALSO SQEXPKERNPARAMINIT, KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2004 Neil D. Lawrence
% 	ardKernParamInit.m CVS version 1.6
% 	ardKernParamInit.m SVN version 471
% 	last update 2009-08-14T07:57:37.000000Z


kern.inverseWidth = 1;
kern.rbfVariance = 1;
kern.whiteVariance = 1; 
kern.biasVariance = 1;
kern.linearVariance = 1;
kern.inputScales = 0.999*ones(1, kern.inputDimension);
kern.nParams = 5 + kern.inputDimension;

kern.transforms(1).index = [1 2 3 4 5];
kern.transforms(1).type = optimiDefaultConstraint('positive');
kern.transforms(2).index = [6:kern.nParams];
kern.transforms(2).type = optimiDefaultConstraint('zeroone');

kern.isStationary = false;