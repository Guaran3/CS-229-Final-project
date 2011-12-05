function k = disimKernCompute(kern, t, t2)

% DISIMKERNCOMPUTE Compute the DISIM kernel given the parameters and X.
%
%	Description:
%
%	K = DISIMKERNCOMPUTE(KERN, T1, T2) computes the kernel parameters
%	for the single input motif kernel given inputs associated with rows
%	and columns.
%	 Returns:
%	  K - the kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  T1 - the input matrix associated with the rows of the kernel.
%	  T2 - the input matrix associated with the columns of the kernel.
%
%	K = DISIMKERNCOMPUTE(KERN, T) computes the kernel matrix for the
%	single input motif kernel given a design matrix of inputs.
%	 Returns:
%	  K - the kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  T - input data matrix in the form of a design matrix.
%	
%
%	See also
%	DISIMKERNPARAMINIT, KERNCOMPUTE, KERNCREATE, DISIMKERNDIAGCOMPUTE


%	Copyright (c) 2006; Antti Honkela, 2007 Neil D. Lawrence
% 	disimKernCompute.m CVS version 1.1
% 	disimKernCompute.m SVN version 163
% 	last update 2009-01-08T09:55:06.000000Z

if nargin < 3
  t2 = t;
end
if size(t, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end

l = sqrt(2/kern.inverseWidth);

h = disimComputeH(t, t2, kern.di_decay, kern.decay, kern.decay, l);
hp = disimComputeHPrime(t, t2, kern.di_decay, kern.decay, kern.decay, l);
if nargin < 3
  k = h + h' + hp + hp';
else
  h2 = disimComputeH(t2, t, kern.di_decay, kern.decay, kern.decay, l);
  hp2 = disimComputeHPrime(t2, t, kern.di_decay, kern.decay, kern.decay, l);
  k = h + h2' + hp + hp2';
end
k = 0.5*k*sqrt(pi)*l;
k = kern.rbf_variance*kern.di_variance*kern.variance*k;
k = real(k);
