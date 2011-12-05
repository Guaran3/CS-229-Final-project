function kern = linardKernParamInit(kern)

% LINARDKERNPARAMINIT LINARD kernel parameter initialisation.
%
%	Description:
%	The automatic relevance determination version of the linear
%	kernel (LINARD) is the simple inner product kernel with feature
%	selection applied.
%	
%	k(x_i, x_j) = sigma2 * x_i'*A* x_j
%	
%	where A is a diagonal matrix of values constrained to be between
%	zero and one. These parameters are stored in the field
%	'inputScales'. There is also the parameter, sigma2, which is stored
%	in the field kern.variance.
%	
%	
%
%	KERN = LINARDKERNPARAMINIT(KERN) initialises the automatic relevance
%	determination linear kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	LINKERNPARAMINIT, RBFARDKERNPARAMINIT, KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	linardKernParamInit.m CVS version 1.5
% 	linardKernParamInit.m SVN version 1
% 	last update 2006-11-20T15:35:57.000000Z


% This parameters is restricted positive.
kern.variance = 1;
% These parameters are restricted to lie between 0 and 1.
kern.inputScales = 0.999*ones(1, kern.inputDimension);
kern.nParams = 1 + kern.inputDimension;

kern.transforms(1).index = 1;
kern.transforms(1).type = optimiDefaultConstraint('positive');
kern.transforms(2).index = [2:kern.nParams];
kern.transforms(2).type = optimiDefaultConstraint('zeroone');

kern.isStationary = false;