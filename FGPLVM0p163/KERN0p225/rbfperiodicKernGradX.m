function gX = rbfperiodicKernGradX(kern, X, X2)

% RBFPERIODICKERNGRADX Gradient of RBFPERIODIC kernel with respect to a point x.
%
%	Description:
%
%	G = RBFPERIODICKERNGRADX(KERN, X) computes the gradient of the RBF
%	derived periodic kernel with respect to the input positions.
%	 Returns:
%	  G - the returned gradients. The gradients are returned in a matrix
%	   which is numData x numInputs x numData. Where numData is the
%	   number of data points and numInputs is the number of input
%	   dimensions in X.
%	 Arguments:
%	  KERN - kernel structure for which gradients are being computed.
%	  X - locations against which gradients are being computed.
%
%	G = RBFPERIODICKERNGRADX(KERN, X1, X2) computes the gradident of the
%	RBF derived periodic kernel with respect to the input positions
%	where both the row positions and column positions are provided
%	separately.
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
%	% SEEALSO RBFPERIODICKERNPARAMINIT, KERNGRADX, RBFPERIODICKERNDIAGGRADX


%	Copyright (c) 2007 Neil D. Lawrence
% 	rbfperiodicKernGradX.m CVS version 1.2
% 	rbfperiodicKernGradX.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
for i = 1:size(X, 1);
  gX(:, :, i) = rbfperiodicKernGradXpoint(kern, X(i, :), X2);
end
  

function gX = rbfperiodicKernGradXpoint(kern, x, X2)

% PERIODICKERNGRADXPOINT Gradient with respect to one point of x.

factor = 2*pi/kern.period;
gX = zeros(size(X2));
arg = factor*(X2 - x)/2;
sinarg = sin(arg);
n2 = sinarg.*sinarg;
wi2 = (2 .* kern.inverseWidth);
rbfPart = kern.variance*exp(-n2*wi2);

gX = factor*kern.inverseWidth*cos(arg).*sinarg.*2.*rbfPart;
