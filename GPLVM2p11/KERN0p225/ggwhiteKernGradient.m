function g = ggwhiteKernGradient(kern, x, varargin)

% GGWHITEKERNGRADIENT Gradient of GG WHITE kernel's parameters.
%
%	Description:
%
%	G = GGWHITEKERNGRADIENT(KERN, X, PARTIAL) computes the gradient of
%	functions with respect to the gaussian gaussian white kernel's
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
%	G = GGWHITEKERNGRADIENT(KERN, X1, X2, PARTIAL) computes the
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
%	GGWHITEKERNPARAMINIT, KERNGRADIENT, GGWHITEKERNDIAGGRADIENT, KERNGRADX


%	Copyright (c) 2008 Mauricio A. Alvarez and Neil D. Lawrence
% 	ggwhiteKernGradient.m SVN version 464
% 	last update 2009-08-12T16:33:55.000000Z

if length(varargin)<2
  x2 = x;
else
  x2 = varargin{1};
end

covGrad = varargin{end};

Lqr = kern.precisionG;
P = Lqr/2;
if kern.isArd
    sqrtP = sqrt(P);
    sqrtPx = x*sparseDiag(sqrtP);
    sqrtPx2 = x2*sparseDiag(sqrtP);
    n2 = dist2(sqrtPx, sqrtPx2);    
else
    dist = dist2(x, x2);
    n2 = P*dist;
end
factor = kern.sigma2Noise*kern.variance^2;    
Kbase = exp(-0.5*n2);
K = factor*Kbase;

if kern.isArd
    matGradLqr = zeros(kern.inputDimension,1);    
    for i=1:kern.inputDimension
        X = repmat(x(:,i),1, size(x2,1));
        X2 = repmat(x2(:,i)',size(x,1),1);
        X_X2 = (X - X2).*(X - X2);
        matGradLqr(i) = sum(sum(0.25*covGrad.*K.*(- X_X2)));        
    end
else    
    matGradLqr = sum(sum(0.25*covGrad.*K.*( - dist)));
end
grad_sigma2Noise = kern.variance^2*sum(sum(covGrad.*Kbase));
grad_variance =  2*kern.variance*kern.sigma2Noise*sum(sum(covGrad.*Kbase));

%g = [matGradLqr(:)' 0 grad_variance];
g = [matGradLqr(:)' grad_sigma2Noise grad_variance];


