function g = mlpardKernGradient(kern, x, varargin)

% MLPARDKERNGRADIENT Gradient of MLPARD kernel's parameters.
%
%	Description:
%
%	G = MLPARDKERNGRADIENT(KERN, X, PARTIAL) computes the gradient of
%	functions with respect to the automatic relevance determination
%	multi-layer perceptron kernel's parameters. As well as the kernel
%	structure and the input positions, the user provides a matrix
%	PARTIAL which gives the partial derivatives of the function with
%	respect to the relevant elements of the kernel matrix.
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
%	G = MLPARDKERNGRADIENT(KERN, X1, X2, PARTIAL) computes the
%	derivatives as above, but input locations are now provided in two
%	matrices associated with rows and columns of the kernel matrix.
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
%	% SEEALSO MLPARDKERNPARAMINIT, KERNGRADIENT, MLPARDKERNDIAGGRADIENT, KERNGRADX


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	mlpardKernGradient.m CVS version 1.5
% 	mlpardKernGradient.m SVN version 328
% 	last update 2009-04-23T11:33:42.000000Z


g = zeros(1, kern.nParams);
if nargin < 4
  [k, sk, innerProd, arg, denom, numer, vecDenom] ...
      = mlpardKernCompute(kern, x);
else
  [k, sk, innerProd, arg, denom, numer, vecDenom1, vecDenom2] ...
      = mlpardKernCompute(kern, x, varargin{1});
end

denom3 = denom.*denom.*denom;
base = 2/pi*kern.variance./sqrt(1-arg.*arg);

baseCovGrad = base.*varargin{end};
if nargin < 4
  vec = diag(innerProd);
  g(1, 1) = sum(sum((innerProd./denom ...
                  -.5*numer./denom3 ...
                  .*((kern.weightVariance.*vec+kern.biasVariance+1)*vec' ...
                     + vec*(kern.weightVariance.*vec+kern.biasVariance+1)')) ...
                 .*baseCovGrad));
  
  g(1, 2) = sum(sum((1./denom ...
                  -.5*numer./denom3 ...
                  .*(repmat(vec, 1, size(vec, 1))*kern.weightVariance...
                     + 2*kern.biasVariance + 2 ...
                     +repmat(vec', size(vec, 1), 1)*kern.weightVariance))...
                 .*baseCovGrad));
else
  scales = sparse(diag(sqrt(kern.inputScales)));
  xt = x*scales;
  vec1 = sum(xt.*xt, 2);
  xt=varargin{1}*scales;
  vec2 = sum(xt.*xt, 2);
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

if nargin < 4
  for j = 1:kern.inputDimension
    x2 = x(:, j).*x(:, j);
    g(1, 3+j) = sum(sum(((x(:, j)*x(:, j)')./denom ...
                      -.5*numer./denom3 ...
                      .*(x2*vecDenom' + vecDenom*x2'))...
                     .*baseCovGrad))*kern.weightVariance;
  end
else
  for j = 1:kern.inputDimension
    x21 = x(:, j).*x(:, j);
    x22 = varargin{1}(:, j).*varargin{1}(:, j);
    g(1, 3+j) = sum(sum(((x(:, j)*varargin{1}(:, j)')./denom ...
                      -.5*numer./denom3 ...
                      .*(x21*vecDenom2' + vecDenom1*x22'))...
                     .*baseCovGrad))*kern.weightVariance;
  end
end
