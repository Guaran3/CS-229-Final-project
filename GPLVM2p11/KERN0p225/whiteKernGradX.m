function gX = whiteKernGradX(kern, X, X2)

% WHITEKERNGRADX Gradient of WHITE kernel with respect to input locations.
%
%	Description:
%
%	G = WHITEKERNGRADX(KERN, X1, X2) computes the gradident of the white
%	noise kernel with respect to the input positions where both the row
%	positions and column positions are provided separately.
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
%	% SEEALSO WHITEKERNPARAMINIT, KERNGRADX, WHITEKERNDIAGGRADX


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	whiteKernGradX.m CVS version 1.5
% 	whiteKernGradX.m SVN version 200
% 	last update 2009-01-23T17:55:00.000000Z

if nargin<3
    X2 = X;
end

gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
