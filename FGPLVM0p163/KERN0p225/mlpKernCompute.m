function [k, sk, innerProd, arg, denom, numer] = mlpKernCompute(kern, x, x2)

% MLPKERNCOMPUTE Compute the MLP kernel given the parameters and X.
%
%	Description:
%
%	K = MLPKERNCOMPUTE(KERN, X, X2) computes the kernel parameters for
%	the multi-layer perceptron kernel given inputs associated with rows
%	and columns.
%	 Returns:
%	  K - the kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  X - the input matrix associated with the rows of the kernel.
%	  X2 - the input matrix associated with the columns of the kernel.
%
%	K = MLPKERNCOMPUTE(KERN, X) computes the kernel matrix for the
%	multi-layer perceptron kernel given a design matrix of inputs.
%	 Returns:
%	  K - the kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  X - input data matrix in the form of a design matrix.
%	
%
%	See also
%	MLPKERNPARAMINIT, KERNCOMPUTE, KERNCREATE, MLPKERNDIAGCOMPUTE


%	Copyright (c) 2004, 2005, 2006, 2009 Neil D. Lawrence
% 	mlpKernCompute.m CVS version 1.4
% 	mlpKernCompute.m SVN version 328
% 	last update 2009-04-23T11:33:42.000000Z


if nargin < 3
  innerProd = x*x';
  numer = innerProd*kern.weightVariance + kern.biasVariance;
  vec = diag(numer) + 1;
  denom = sqrt(vec*vec');
  arg = numer./denom;
  sk = 2/pi*asin(arg);
  k = kern.variance*sk;
else
  innerProd = x*x2';  
  numer = innerProd*kern.weightVariance + kern.biasVariance;
  vec1 = sum(x.*x, 2)*kern.weightVariance + kern.biasVariance + 1;
  vec2 = sum(x2.*x2, 2)*kern.weightVariance + kern.biasVariance + 1;
  denom = sqrt(vec1*vec2');
  arg = numer./denom;
  sk = 2/pi*asin(arg);
  k = kern.variance*sk;
end
