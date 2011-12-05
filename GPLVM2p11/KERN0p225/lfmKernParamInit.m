function kern = lfmKernParamInit(kern)

% LFMKERNPARAMINIT LFM kernel parameter initialisation. The latent force
%
%	Description:
%	model (LFM) kernel is the result of a second order differential equation
%	where there is assumed to be a force driving the system which is drawn
%	from a Gaussian process with an RBF kernel, i.e. we have the following
%	differential equation,
%	
%	B + S f(t-delta) = m x''(t) + cx'(t) + kx(t),
%	
%	where m is a mass, c is a damping coefficient, k is a spring constant,
%	S is a scalar sensitivity, B is the initial level and delta is a time
%	delay.
%	
%	If f(t) is assumed to come from a Gaussian process with an RBF covariance
%	function x(t) is a Gaussian process with a covariance function provided by
%	the single latent force model kernel. Further details about the structure
%	of the kernel can be found in: M. Alvarez, D. Luengo and N. D. Lawrence,
%	"Latent Force Models", Proc. AISTATS 2009.
%	
%	The kernel is designed to interoperate with the multiple output block
%	kernel so that f(t) can be inferred given several different
%	instantiations of x(t).
%	
%	The parameters (m, c, delta and k) are constrained positive.
%	
%
%	KERN = LFMKERNPARAMINIT(KERN) initialises the latent force model
%	kernel structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%	
%
%	See also
%	KERNCREATE, KERNPARAMINIT, LFMKERNCOMPUTE


%	Copyright (c) 2007 Neil D. Lawrence


%	With modifications by David Luengo 2008, 2009
% 	lfmKernParamInit.m SVN version 355
% 	last update 2009-05-14T11:55:32.000000Z


if kern.inputDimension > 1
  error('LFM kernel only valid for one-D input.')
end

kern.delay = 0;
kern.mass = 1;
kern.spring = 1;
kern.damper = 1;
kern.sensitivity = 1;

kern.initVal = 1;
kern.inverseWidth = 1;
kern.variance = 1;
kern.nParams = 5;

kern.transforms.index = [1 2 3 4];
kern.transforms.type = optimiDefaultConstraint('positive');

kern.isStationary = false;
kern.positiveTime = true;

% Serial number used to distinguish LFM kernels
maxSerial = double(intmax('uint64'));
kern.serialNumber = uint64(1+rand(1)*maxSerial);

% Force any precomputation contained in lfmKernExpandParam
params = lfmKernExtractParam(kern);
kern = lfmKernExpandParam(kern, params);
