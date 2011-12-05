function K = disimXdisimKernCompute(disimKern1, disimKern2, t1, t2)

% DISIMXDISIMKERNCOMPUTE Compute a cross kernel between two DISIM kernels.
%
%	Description:
%
%	K = DISIMXDISIMKERNCOMPUTE(DISIMKERN1, DISIMKERN2, T) computes cross
%	kernel terms between two DISIM kernels for the multiple output
%	kernel.
%	 Returns:
%	  K - block of values from kernel matrix.
%	 Arguments:
%	  DISIMKERN1 - the kernel structure associated with the first DISIM
%	   kernel.
%	  DISIMKERN2 - the kernel structure associated with the second DISIM
%	   kernel.
%	  T - inputs for which kernel is to be computed.
%
%	K = DISIMXDISIMKERNCOMPUTE(DISIMKERN1, DISIMKERN2, T1, T2) computes
%	cross kernel terms between two DISIM kernels for the multiple output
%	kernel.
%	 Returns:
%	  K - block of values from kernel matrix.
%	 Arguments:
%	  DISIMKERN1 - the kernel structure associated with the first DISIM
%	   kernel.
%	  DISIMKERN2 - the kernel structure associated with the second DISIM
%	   kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, DISIMKERNPARAMINIT


%	Copyright (c) 2006 Neil D. Lawrence
%	Copyright (c) 2007 Antti Honkela
% 	disimXdisimKernCompute.m CVS version 1.1
% 	disimXdisimKernCompute.m SVN version 163
% 	last update 2009-01-08T09:55:06.000000Z

if nargin < 4
  t2 = t1;
end
if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
if disimKern1.inverseWidth ~= disimKern2.inverseWidth
  error('Kernels cannot be cross combined if they have different inverse widths.')
end
if disimKern1.di_decay ~= disimKern2.di_decay
  error('Kernels cannot be cross combined if they have different driving input decays.');
end
if disimKern1.di_variance ~= disimKern2.di_variance
  error('Kernels cannot be cross combined if they have different driving input variances.');
end
if disimKern1.rbf_variance ~= disimKern2.rbf_variance
  error('Kernels cannot be cross combined if they have different RBF variances.');
end

l = sqrt(2/disimKern1.inverseWidth);
h1 = disimComputeH(t1, t2, disimKern1.di_decay, disimKern1.decay, disimKern2.decay, l);
h2 = disimComputeH(t2, t1, disimKern1.di_decay, disimKern2.decay, disimKern1.decay, l);
hp1 = disimComputeHPrime(t1, t2, disimKern1.di_decay, disimKern1.decay, disimKern2.decay, l);
hp2 = disimComputeHPrime(t2, t1, disimKern1.di_decay, disimKern2.decay, disimKern1.decay, l);
K = h1 + h2' + hp1 + hp2';
K = 0.5*K*sqrt(pi)*l;
K = disimKern1.rbf_variance*disimKern1.di_variance*sqrt(disimKern1.variance)*sqrt(disimKern2.variance)*K;
