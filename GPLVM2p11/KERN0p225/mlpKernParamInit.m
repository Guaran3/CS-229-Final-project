function kern = mlpKernParamInit(kern)

% MLPKERNPARAMINIT MLP kernel parameter initialisation.
%
%	Description:
%	The multi-layer perceptron kernel (MLP) is sometimes also known
%	as the arcsin kernel. It is derived by considering the infinite
%	limit of a neural network with erf() functions as the hidden
%	layer activations.
%	
%	k(x_i, x_j) = sigma2*arcsin((w*x_i'*x_j + b) ...
%	/sqrt((w*x_i'*x_i + b + 1)*(w*x_j'*x_j + b + 1)))
%	
%	There are three parameters, the kernel variance (sigma2) stored
%	in kern.variance, the variance of the weights in the neural
%	network (w) stored in kern.weightVariance and the variances of
%	the biases in the neural network (kern.biasVariance). There is
%	also an ARD variant of this kernel.
%	
%	
%
%	KERN = MLPKERNPARAMINIT(KERN) initialises the multi-layer perceptron
%	kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	MLPARDKERNPARAMINIT, KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	mlpKernParamInit.m CVS version 1.5
% 	mlpKernParamInit.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


kern.weightVariance = 10;
kern.biasVariance = 10;
kern.variance = 1;
kern.nParams = 3;

kern.transforms.index = [1 2 3];
kern.transforms.type = optimiDefaultConstraint('positive');

kern.isStationary = false;