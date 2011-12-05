function gX = biasKernGradX(kern, X, X2)

% BIASKERNGRADX Gradient of BIAS kernel with respect to input locations.
%
%	Description:
%
%	G = BIASKERNGRADX(KERN, X1, X2) computes the gradident of the bias
%	kernel with respect to the input positions where both the row
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
%	% SEEALSO BIASKERNPARAMINIT, KERNGRADX, BIASKERNDIAGGRADX


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	biasKernGradX.m CVS version 1.5
% 	biasKernGradX.m SVN version 1
% 	last update 2006-10-25T10:53:00.000000Z


gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
