function gX = rbfardKernGradX(kern, X, X2)

% RBFARDKERNGRADX Gradient of RBFARD kernel with respect to input locations.
%
%	Description:
%
%	G = RBFARDKERNGRADX(KERN, X1, X2) computes the gradident of the
%	automatic relevance determination radial basis function kernel with
%	respect to the input positions where both the row positions and
%	column positions are provided separately.
%	 Returns:
%	  G - the returned gradients. The gradients are returned in a matrix
%	   which is numData2 x numInputs x numData1. Where numData1 is the
%	   number of data points in X1, numData2 is the number of data points
%	   in X2 and numInputs is the number of input dimensions in X.
%	 Arguments:
%	  KERN - kernel structure for which gradients are being computed.
%	  X1 - row locations against which gradients are being computed.
%	  X2 - column locations against which gradients are being computed.
%	
%
%	See also
%	% SEEALSO RBFARDKERNPARAMINIT, KERNGRADX, RBFARDKERNDIAGGRADX


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	rbfardKernGradX.m CVS version 1.6
% 	rbfardKernGradX.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
for i = 1:size(X, 1);
  gX(:, :, i) = rbfardKernGradXpoint(kern, X(i, :), X2);
end
  

function gX = rbfardKernGradXpoint(kern, x, X2)

% RBFARDKERNGRADXPOINT Gradient with respect to one point of x.

scales = sparse(sqrt(diag(kern.inputScales)));
gX = zeros(size(X2));
n2 = dist2(X2*scales, x*scales);
wi2 = (.5 .* kern.inverseWidth);
rbfPart = kern.variance*exp(-n2*wi2);
for i = 1:size(x, 2)
  gX(:, i) = kern.inverseWidth*kern.inputScales(i)*(X2(:, i) - x(i)).*rbfPart;
end
