function kern = rbfinfwhiteKernParamInit(kern)

% RBFINFWHITEKERNPARAMINIT The RBF-WHITE-INF kernel is a convolutional
%
%	Description:
%	kernel obtained as the result of convolving a white noise input process
%	with an RBF smoothing kernel with range between minus and plus infinity.
%	
%	Although it be used independently, it is mostly intended to be combined
%	with other kernels in a compound kernel. For example, this is the kernel
%	used as variational smoothing kernel for the DTC sparse GP approach.
%	
%	The parameters are sigma2, the process variance (kern.variance), and
%	gamma, the inverse width (kern.inverseWidth). The inverse width controls
%	how wide the basis functions are, the larger gamma, the smaller the basis
%	functions are.
%	
%	It is very similar to the RBF-WHITE kernel.
%	
%	
%
%	KERN = RBFINFWHITEKERNPARAMINIT(KERN) initialises the RBF-WHITE
%	kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	CMPNDKERNPARAMINIT, RBFWHITEKERNPARAMINIT, KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2009 David Luengo
% 	rbfinfwhiteKernParamInit.m SVN version 362
% 	last update 2009-06-02T22:01:41.000000Z


if kern.inputDimension > 1
  error('RBF-WHITE kernel only valid for one-D input.')
end

kern.nParams = 2;
kern.inverseWidth = 1;
kern.variance = 1;

% Constrains parameters to be positive for optimisation.
kern.transforms.index = [1 2];
kern.transforms.type = optimiDefaultConstraint('positive');
kern.isStationary = true;
