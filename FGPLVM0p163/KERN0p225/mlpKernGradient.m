function g = mlpKernGradient(kern, x, varargin)

% MLPKERNGRADIENT Gradient of MLP kernel's parameters.
%
%	Description:
%
%	G = MLPKERNGRADIENT(KERN, X, PARTIAL) computes the gradient of
%	functions with respect to the multi-layer perceptron kernel's
%	parameters. As well as the kernel structure and the input positions,
%	the user provides a matrix PARTIAL which gives the partial
%	derivatives of the function with respect to the relevant elements of
%	the kernel matrix.
%	 Returns:
%	  G - gradients of the function of interest with respect to the
%	   kernel parameters. The ordering of the vector should match that
%	   provided by the function kernExtractParam.
%	 Arguments:
%	  KERN - the kernel structure for which the gradients are being
%	   computed.
%	  X - the input locations for which the gradients are being
%	   computed.
%	  PARTIAL - matrix of partial derivatives of the function of
%	   interest with respect to the kernel matrix. The argument takes the
%	   form of a square matrix of dimension  numData, where numData is
%	   the number of rows in X.
%
%	G = MLPKERNGRADIENT(KERN, X1, X2, PARTIAL) computes the derivatives
%	as above, but input locations are now provided in two matrices
%	associated with rows and columns of the kernel matrix.
%	 Returns:
%	  G - gradients of the function of interest with respect to the
%	   kernel parameters.
%	 Arguments:
%	  KERN - the kernel structure for which the gradients are being
%	   computed.
%	  X1 - the input locations associated with the rows of the kernel
%	   matrix.
%	  X2 - the input locations associated with the columns of the kernel
%	   matrix.
%	  PARTIAL - matrix of partial derivatives of the function of
%	   interest with respect to the kernel matrix. The matrix should have
%	   the same number of rows as X1 and the same number of columns as X2
%	   has rows.
%	
%
%	See also
%	% SEEALSO MLPKERNPARAMINIT, KERNGRADIENT, MLPKERNDIAGGRADIENT, KERNGRADX


%	Copyright (c) 2004, 2005, 2006, 2009 Neil D. Lawrence
% 	mlpKernGradient.m CVS version 1.5
% 	mlpKernGradient.m SVN version 328
% 	last update 2009-04-23T11:33:42.000000Z


if nargin < 4
  [k, sk, innerProd, arg, denom, numer] = mlpKernCompute(kern, x);
else
  [k, sk, innerProd, arg, denom, numer] = mlpKernCompute(kern, x, varargin{1});
end
denom3 = denom.*denom.*denom;
base = 2/pi*kern.variance./sqrt(1-arg.*arg);
baseCovGrad = base.*varargin{end};

if nargin < 4
  vec = diag(innerProd);
  g(1, 1) = sum(sum((innerProd./denom ...
                     -.5*numer./denom3...
                     .*((kern.weightVariance.*vec+kern.biasVariance+1)*vec' ...
                        + vec*(kern.weightVariance.*vec+kern.biasVariance+1)')).*baseCovGrad));
  g(1, 2) = sum(sum((1./denom ...
                     -.5*numer./denom3 ...
                     .*(repmat(vec, 1, size(vec, 1))*kern.weightVariance...
                        + 2*kern.biasVariance + 2 ...
                        +repmat(vec', size(vec, 1), 1)* ...
                        kern.weightVariance)).*baseCovGrad));
else
  vec1 = sum(x.*x, 2);
  vec2 = sum(varargin{1}.*varargin{1}, 2);
  g(1, 1) = sum(sum((innerProd./denom ...
                     -.5*numer./denom3...
                     .*((kern.weightVariance.*vec1+kern.biasVariance+1)*vec2' ...
                        + vec1*(kern.weightVariance.*vec2+kern.biasVariance+1)')).*baseCovGrad));
  g(1, 2) = sum(sum((1./denom ...
                     -.5*numer./denom3 ...
                     .*(repmat(vec1, 1, size(vec2, 1))*kern.weightVariance...
                        + 2*kern.biasVariance + 2 ...
                        +repmat(vec2', size(vec1, 1), 1)* ...
                        kern.weightVariance)).*baseCovGrad));
end
g(1, 3) = sum(sum(sk.*varargin{end}));
