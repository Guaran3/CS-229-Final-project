function gX = linardKernGradX(kern, X, X2)

% LINARDKERNGRADX Gradient of LINARD kernel with respect to input locations.
%
%	Description:
%
%	G = LINARDKERNGRADX(KERN, X1, X2) computes the gradident of the
%	automatic relevance determination linear kernel with respect to the
%	input positions where both the row positions and column positions
%	are provided separately.
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
%	% SEEALSO LINARDKERNPARAMINIT, KERNGRADX, LINARDKERNDIAGGRADX


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	linardKernGradX.m CVS version 1.5
% 	linardKernGradX.m SVN version 1
% 	last update 2006-10-25T10:53:00.000000Z


scales = sparse(diag(kern.inputScales));
X2 = X2*scales;

gX = repmat(kern.variance.*X2, [1 1 size(X, 1)]);
