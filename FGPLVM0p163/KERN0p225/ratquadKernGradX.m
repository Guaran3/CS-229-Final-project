function gX = ratquadKernGradX(kern, X, X2)

% RATQUADKERNGRADX Gradient of RATQUAD kernel with respect to input locations.
%
%	Description:
%
%	G = RATQUADKERNGRADX(KERN, X1, X2) computes the gradident of the
%	rational quadratic kernel with respect to the input positions where
%	both the row positions and column positions are provided separately.
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
%	% SEEALSO RATQUADKERNPARAMINIT, KERNGRADX, RATQUADKERNDIAGGRADX


%	Copyright (c) 2006 Neil D. Lawrence
% 	ratquadKernGradX.m CVS version 1.3
% 	ratquadKernGradX.m SVN version 1
% 	last update 2007-07-24T23:24:39.000000Z

gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
for i = 1:size(X, 1);
  gX(:, :, i) = ratquadKernGradXpoint(kern, X(i, :), X2);
end
  

function gX = ratquadKernGradXpoint(kern, x, X2)

% RATQUADKERNGRADXPOINT Gradient with respect to one point of x.

gX = zeros(size(X2));
n2 = dist2(X2, x);
wi2 = (.5/(kern.lengthScale*kern.lengthScale*kern.alpha));
ratquadPart = kern.variance*(1+n2*wi2).^-(kern.alpha+1)/(kern.lengthScale*kern.lengthScale);
for i = 1:size(x, 2)
  gX(:, i) =(X2(:, i) - x(i)).*ratquadPart;
end
