function K = lfmXrbfKernCompute(lfmKern, rbfKern, t1, t2)

% LFMXRBFKERNCOMPUTE Compute a cross kernel between the LFM and RBF kernels.
%
%	Description:
%
%	K = LFMXRBFKERNCOMPUTE(LFMKERN, RBFKERN, T) computes cross kernel
%	terms between LFM and RBF kernels for the multiple output kernel.
%	 Returns:
%	  K - block of values from kernel matrix.
%	 Arguments:
%	  LFMKERN - the kernel structure associated with the LFM kernel.
%	  RBFKERN - the kernel structure associated with the RBF kernel.
%	  T - inputs for which kernel is to be computed.
%
%	K = LFMXRBFKERNCOMPUTE(LFMKERN, RBFKERN, T1, T2) computes cross
%	kernel terms between LFM and RBF kernels for the multiple output
%	kernel.
%	 Returns:
%	  K - block of values from kernel matrix.
%	 Arguments:
%	  LFMKERN - the kernel structure associated with the LFM kernel.
%	  RBFKERN - the kernel structure associated with the RBF kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, LFMKERNPARAMINIT, RBFKERNPARAMINIT


%	Copyright (c) 2007, 2008, Mauricio Alvarez, 2008 David Luengo


%	With modifications by Neil D. Lawrence 2007
% 	lfmXrbfKernCompute.m SVN version 87
% 	last update 2008-09-16T09:36:30.000000Z


if nargin < 4
  t2 = t1;
end
if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
if lfmKern.inverseWidth ~= rbfKern.inverseWidth
  error('Kernels cannot be cross combined if they have different inverse widths.')
end
  
% Get length scale out.
sigma2 = 2/lfmKern.inverseWidth;
sigma = sqrt(sigma2);

% Parameters of the kernel
alpha = lfmKern.damper./(2*lfmKern.mass);
omega = sqrt(lfmKern.spring./lfmKern.mass - alpha.*alpha);

% Kernel evaluation
if isreal(omega)
    gamma = alpha + j*omega;
%     K = -(sqrt(pi)*sigma*lfmKern.sensitivity/(2*lfmKern.mass*omega)) ...
%         *imag(lfmComputeUpsilon(gamma,sigma2,t1, t2, 2));
    
    K = -(sqrt(pi)*sigma*lfmKern.sensitivity/(2*lfmKern.mass*omega)) ...
        *imag(lfmComputeUpsilonMatrix(gamma,sigma2, t1,t2));    
else
    gamma1 = alpha + j*omega;
    gamma2 = alpha - j*omega;
%     K(:,:) = (sqrt(pi)*sigma*lfmKern.sensitivity/(j*4*lfmKern.mass*omega)) ...
%         *(lfmComputeUpsilon(gamma2,sigma2,t1, t2, 2 ) - ...
%           lfmComputeUpsilon(gamma1,sigma2,t1, t2, 2));
      
   K(:,:) = (sqrt(pi)*sigma*lfmKern.sensitivity/(j*4*lfmKern.mass*omega)) ...
        *(lfmComputeUpsilonMatrix(gamma2,sigma2,t1, t2) - ...
          lfmComputeUpsilonMatrix(gamma1,sigma2,t1, t2));        
end
