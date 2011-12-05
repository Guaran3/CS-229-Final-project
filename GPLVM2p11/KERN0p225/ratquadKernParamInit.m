function kern = ratquadKernParamInit(kern)

% RATQUADKERNPARAMINIT RATQUAD kernel parameter initialisation.
%
%	Description:
%	The rational quadratic kernel is a scale mixture of radial basis
%	function kernels (RBF). Each component of the mixture has a
%	different length scale. A gamma prior distribution is placed over
%	the inverse scale to obtain the kernel. The a parameter of the
%	gamma prior is given by alpha and the b parameter by
%	1/(l*l).
%	
%	k(x_i, x_j) = sigma2 * (1 + (x_i - x_j)'*(x_i - x_j)/(2*alpha*l*l))^-alpha
%	
%	The parameters are sigma2, the process variance (kern.variance),
%	l (kern.lengthScale) and alpha (kern.alpha).
%	
%
%	KERN = RATQUADKERNPARAMINIT(KERN) initialises the rational quadratic
%	kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2006 Neil D. Lawrence
% 	ratquadKernParamInit.m CVS version 1.2
% 	ratquadKernParamInit.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z

kern.alpha = 1;
kern.lengthScale = 1;
kern.variance = 1;
kern.nParams = 3;

kern.transforms.index = [1 2 3];
kern.transforms.type = optimiDefaultConstraint('positive');

kern.isStationary = true;