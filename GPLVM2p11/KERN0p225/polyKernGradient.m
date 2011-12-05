function g = polyKernGradient(kern, x, varargin)

% POLYKERNGRADIENT Gradient of POLY kernel's parameters.
%
%	Description:
%
%	G = POLYKERNGRADIENT(KERN, X, PARTIAL) computes the gradient of
%	functions with respect to the polynomial kernel's parameters. As
%	well as the kernel structure and the input positions, the user
%	provides a matrix PARTIAL which gives the partial derivatives of the
%	function with respect to the relevant elements of the kernel matrix.
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
%	G = POLYKERNGRADIENT(KERN, X1, X2, PARTIAL) computes the derivatives
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
%	% SEEALSO POLYKERNPARAMINIT, KERNGRADIENT, POLYKERNDIAGGRADIENT, KERNGRADX


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	polyKernGradient.m CVS version 1.3
% 	polyKernGradient.m SVN version 1
% 	last update 2006-10-25T10:53:01.000000Z


if nargin < 4
  innerProd = x*x';
else
  innerProd = x*varargin{1}';
end
arg = kern.weightVariance*innerProd+kern.biasVariance;
base = kern.variance*kern.degree*arg.^(kern.degree-1);
baseCovGrad = base.*varargin{end};


g(1) = sum(sum(innerProd.*baseCovGrad));
g(2) = sum(sum(baseCovGrad));
g(3) = sum(sum(varargin{end}.*arg.^kern.degree));

