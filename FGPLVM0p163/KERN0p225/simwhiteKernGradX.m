function gT = simwhiteKernGradX(kern, t1, t2)

% SIMWHITEKERNGRADX Gradient of SIM-WHITE kernel with respect to a point t.
%
%	Description:
%
%	GT = SIMWHITEKERNGRADX(KERN, T1) computes the gradient of the
%	SIM-White (Single Input Motif - White) kernel with respect to the
%	input positions.
%	 Returns:
%	  GT - the returned gradients. The gradients are returned in a
%	   matrix which is numData x numInputs x numData. Where numData is
%	   the number of data points and numInputs is the number of input
%	   dimensions in t1 (currently always one).
%	 Arguments:
%	  KERN - kernel structure for which gradients are being computed.
%	  T1 - locations against which gradients are being computed.
%
%	GT = SIMWHITEKERNGRADX(KERN, T1, T2) computes the gradident of the
%	SIM-White (Single Input Motif - White) kernel with respect to the
%	input positions where both the row positions and column positions
%	are provided separately.
%	 Returns:
%	  GT - the returned gradients. The gradients are returned in a
%	   matrix which is numData2 x numInputs x numData1. Where numData1 is
%	   the number of data points in t1, numData2 is the number of data
%	   points in t2 and numInputs is the number of input dimensions in t1
%	   (currently always one).
%	 Arguments:
%	  KERN - kernel structure for which gradients are being computed.
%	  T1 - row locations against which gradients are being computed.
%	  T2 - column locations against which gradients are being computed.
%	
%
%	See also
%	% SEEALSO SIMWHITEKERNPARAMINIT, KERNGRADX, SIMWHITEKERNDIAGGRADX


%	Copyright (c) 2009 David Luengo
% 	simwhiteKernGradX.m SVN version 362
% 	last update 2009-06-02T22:01:42.000000Z


if nargin < 3
  t2 = t1;
end
if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end

% Initialisation of the gradient matrix
gT = zeros(size(t1, 1), 1, size(t2, 1));

% Parameters of the kernel required in the computation
variance = kern.variance;
decay = kern.decay;
sensitivity = kern.sensitivity;
isStationary = kern.isStationary;

c = 0.5 * variance * (sensitivity^2);
if (isStationary == false)
    for i = size(t1, 1)
        gT(i, 1, :) =  - sign(t1(i)-t2) .* exp(-decay*abs(t1(i)-t2)) ...
                + exp(-decay*(t1(i)+t2));
    end
else
    for i = size(t1, 1)
        gT(i, 1, :) =  - sign(t1(i)-t2) .* exp(-decay*abs(t1(i)-t2));
    end
end
gT = c * gT;
