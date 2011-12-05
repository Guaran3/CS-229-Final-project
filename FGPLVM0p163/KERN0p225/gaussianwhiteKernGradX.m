function gX = gaussianwhiteKernGradX(kern,X, X2)

% GAUSSIANWHITEKERNGRADX Gradient of gaussian white kernel with respect
%
%	Description:
%	to input locations.
%
%	G = GAUSSIANWHITEKERNGRADX(KERN, X, X2) computes the gradient of the
%	gaussian white kernel with respect to the input positions where both
%	the row positions and column positions are provided separately.
%	 Returns:
%	  G - the returned gradients. The gradients are returned in a matrix
%	   which is numData2 x numInputs x numData1. Where numData1 is the
%	   number of data points in X1, numData2 is the number of data points
%	   in X2 and numInputs is the number of input dimensions in X.
%	 Arguments:
%	  KERN - kernel structure for which gradients are being computed.
%	  X - row locations against which gradients are being computed.
%	  X2 - column locations against which gradients are being computed.
%	
%	
%
%	See also
%	GAUSSIANWHITEKERNPARAMINIT, KERNGRADX, GAUSSIANWHITEKERNDIAGGRADX


%	Copyright (c) 2008 Mauricio A. Alvarez and Neil D. Lawrence


%	With modifications by Mauricio A. Alvarez 2009.
% 	gaussianwhiteKernGradX.m SVN version 426
% 	last update 2009-07-17T10:58:28.000000Z

if nargin < 3,
    X2 = X;
end
if kern.isArd
    if kern.nIndFunct == 1
        [K, P]  = gaussianwhiteKernCompute(kern, X, X2);
        PX = X*sparseDiag(P);
        PX2 = X2*sparseDiag(P);
        gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
        for i = 1:size(X, 1);
            gX(:, :, i) = gaussianwhiteKernGradXpoint(PX(i, :), PX2, K(i,:)');
        end
    else
        [K, P] = gaussianwhiteKernCompute(kern, X);
        gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
        for j = 1:size(X,2)
            for i = 1:size(X, 1);
                partialDer = (K(i,:).*P(i,:,j))';
                gX(:, j, i) = gaussianwhiteKernGradXpoint( X(i, j), X2(:,j), partialDer);
            end
        end        
    end
else
    if kern.nIndFunct == 1
        [K, P]  = gaussianwhiteKernCompute(kern, X, X2);
        PX = P*X;
        PX2 = P*X2;
        gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
        for i = 1:size(X, 1);
            gX(:, :, i) = gaussianwhiteKernGradXpoint(PX(i, :), PX2, K(i,:)');
        end
    else
        [K, P] = gaussianwhiteKernCompute(kern, X);        
        gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));
        for i = 1:size(X, 1);
            partialDer = (K(i,:).*P(i,:))';
            gX(:, :, i) = gaussianwhiteKernGradXpoint( X(i, :), X2, partialDer);
        end
    end
end

gX = gX*2;
dgKX = gaussianwhiteKernDiagGradX(kern, X);
for i = 1:size(X,1)
    gX(i, :, i) = dgKX(i, :);
end

function gX = gaussianwhiteKernGradXpoint(x, x2, partialDer)

% GAUSSIANWHITEKERNGRADXPOINT Gradient with respect to one point of x.

gX = zeros(size(x2));
for i = 1:size(x, 2)
  gX(:, i) = (x2(:, i) - x(i)).*partialDer;
end
