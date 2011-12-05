function g = rbfard2KernDiagGradient(kern, x, covDiag)

% RBFARD2KERNDIAGGRADIENT Compute the gradient of the RBFARD2 kernel's diagonal wrt parameters.
%
%	Description:
%
%	G = RBFARD2KERNDIAGGRADIENT(KERN, X, FACTORS) computes the gradient
%	of functions of the diagonal of the automatic relevance
%	determination radial basis function kernel matrix with respect to
%	the parameters of the kernel. The parameters' gradients are returned
%	in the order given by the rbfard2KernExtractParam command.
%	 Returns:
%	  G - gradients of the relevant function with respect to each of the
%	   parameters. Ordering should match the ordering given in
%	   rbfard2KernExtractParam.
%	 Arguments:
%	  KERN - the kernel structure for which the gradients are computed.
%	  X - the input data for which the gradient is being computed.
%	  FACTORS - partial derivatives of the function of interest with
%	   respect to the diagonal elements of the kernel.
%	
%	
%
%	See also
%	RBFARD2KERNPARAMINIT, KERNDIAGGRADIENT, RBFARD2KERNEXTRACTPARAM, RBFARD2KERNGRADIENT


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
%	Copyright (c) 2009 Michalis K. Titsias
% 	rbfard2KernDiagGradient.m SVN version 582
% 	last update 2009-11-08T13:06:33.000000Z


g = zeros(1, size(x, 2)+1);
g(1) = sum(covDiag);