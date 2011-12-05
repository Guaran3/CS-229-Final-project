function g = kernDiagGradient(kern, x, covDiag)

% KERNDIAGGRADIENT Compute the gradient of the kernel's parameters for the diagonal.
%
%	Description:
%
%	G = KERNDIAGGRADIENT(KERN, X, FACTORS) computes the gradient of
%	functions of the diagonal of the kernel matrix with respect to the
%	parameters of the kernel. The parameters' gradients are returned in
%	the order given by the kernExtractParam command.
%	 Returns:
%	  G - gradients of the relevant function with respect to each of the
%	   parameters. Ordering should match the ordering given in
%	   kernExtractParam.
%	 Arguments:
%	  KERN - the kernel structure for which the gradients are computed.
%	  X - the input data for which the gradient is being computed.
%	  FACTORS - partial derivatives of the function of interest with
%	   respect to the diagonal elements of the kernel matrix.
%
%	See also
%	KERNDIAGGRADIENT, KERNEXTRACTPARAM, KERNGRADIENT
% 	kernDiagGradient.m CVS version 1.2
% 	kernDiagGradient.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


fileName = [kern.type 'KernDiagGradient'];
if exist(fileName) == 2
  fhandle = str2func(fileName);
  g = fhandle(kern, x, covDiag);
else
  fhandle = str2func([kern.type 'KernGradient']);
  g = zeros(1, kern.nParams);
  for i = 1:size(x, 1)
    g = g ...
        + fhandle(kern, x(i, :), covDiag(i));
  end
end
% Check if parameters are being optimised in a transformed space.
factors = kernFactors(kern, 'gradfact');
g(factors.index) = g(factors.index).*factors.val;

  
