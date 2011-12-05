function g = whitehKernGradient(kern, x, varargin)

% WHITEHKERNGRADIENT Gradient of WHITEH kernel's parameters.
%
%	Description:
%
%	G = WHITEHKERNGRADIENT(KERN, X, PARTIAL) computes the gradient of
%	functions with respect to the whiteh noise kernel's parameters. As
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
%	G = WHITEHKERNGRADIENT(KERN, X1, X2, PARTIAL) computes the
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
%	% SEEALSO WHITEHKERNPARAMINIT, KERNGRADIENT, WHITEHKERNDIAGGRADIENT, KERNGRADX


%	Copyright (c) Neil D. Lawrence, 2009 Mauricio A. Alvarez
% 	whitehKernGradient.m SVN version 453
% 	last update 2009-08-12T16:33:56.000000Z

if nargin < 4
  g(1, 1) = sum(diag(varargin{end}).*(1./x(:,end)));
else
  g = 0;
end