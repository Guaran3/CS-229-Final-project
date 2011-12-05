function k = matern52KernDiagCompute(kern, x)

% MATERN52KERNDIAGCOMPUTE Compute diagonal of MATERN52 kernel.
%
%	Description:
%
%	K = MATERN52KERNDIAGCOMPUTE(KERN, X) computes the diagonal of the
%	kernel matrix for the matern kernel with nu=5/2 kernel given a
%	design matrix of inputs.
%	 Returns:
%	  K - a vector containing the diagonal of the kernel matrix computed
%	   at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  X - input data matrix in the form of a design matrix.
%	
%
%	See also
%	MATERN52KERNPARAMINIT, KERNDIAGCOMPUTE, KERNCREATE, MATERN52KERNCOMPUTE


%	Copyright (c) 2006 Neil D. Lawrence
% 	matern52KernDiagCompute.m CVS version 1.1
% 	matern52KernDiagCompute.m SVN version 1
% 	last update 2006-10-25T10:53:00.000000Z

k = repmat(kern.variance, size(x, 1), 1);
