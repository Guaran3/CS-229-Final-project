function [g1, g2] = rbfinfwhiteXrbfinfwhiteKernGradient(rbfKern1, rbfKern2, t1, varargin)

% RBFINFWHITEXRBFINFWHITEKERNGRADIENT Compute a cross gradient between two
%
%	Description:
%	RBF-WHITE kernels (with integration limits between minus infinity and
%	infinity).
%
%	[G1, G2] = RBFINFWHITEXRBFINFWHITEKERNGRADIENT(RBFKERN1, RBFKERN2,
%	T1, COVGRAD) computes cross gradient of parameters of a cross kernel
%	between two RBF-WHITE kernels for the multiple output kernel.
%	 Returns:
%	  G1 - gradient of the parameters of the first kernel, for ordering
%	   see rbfwhiteKernExtractParam.
%	  G2 - gradient of the parameters of the second kernel, for ordering
%	   see rbfwhiteKernExtractParam.
%	 Arguments:
%	  RBFKERN1 - the kernel structure associated with the first
%	   RBF-WHITE kernel.
%	  RBFKERN2 - the kernel structure associated with the second
%	   RBF-WHITE kernel.
%	  T1 - inputs for which kernel is to be computed.
%	  COVGRAD - gradient of the objective function with respect to the
%	   elements of the cross kernel matrix.
%
%	[G1, G2] = RBFINFWHITEXRBFINFWHITEKERNGRADIENT(RBFKERN1, RBFKERN2,
%	T1, T2, COVGRAD) computes cross kernel terms between two RBF-WHITE
%	kernels for the multiple output kernel.
%	 Returns:
%	  G1 - gradient of the parameters of the first kernel, for ordering
%	   see rbfwhiteKernExtractParam.
%	  G2 - gradient of the parameters of the second kernel, for ordering
%	   see rbfwhiteKernExtractParam.
%	 Arguments:
%	  RBFKERN1 - the kernel structure associated with the first
%	   RBF-WHITE kernel.
%	  RBFKERN2 - the kernel structure associated with the second
%	   RBF-WHITE kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	  COVGRAD - gradient of the objective function with respect to the
%	   elements of the cross kernel matrix.
%	rbfinfwhiteKernExtractParam
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, RBFINFWHITEKERNPARAMINIT, 


%	Copyright (c) 2009 David Luengo
% 	rbfinfwhiteXrbfinfwhiteKernGradient.m SVN version 362
% 	last update 2009-06-02T22:01:41.000000Z


if nargin < 5
    t2 = t1;
else
    t2 = varargin{1};
end
covGrad = varargin{end};

if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
if rbfKern1.variance ~= rbfKern2.variance
  error('Kernels cannot be cross combined if they have different variances.')
end

g1 = zeros(1, rbfKern1.nParams);
g2 = zeros(1, rbfKern2.nParams);

T1 = repmat(t1, 1, size(t2, 1));
T2 = repmat(t2.', size(t1, 1), 1);
deltaT = T1 - T2;

% Parameters required for further computations
variance = rbfKern1.variance;
invWidth1 = rbfKern1.inverseWidth;
invWidth2 = rbfKern2.inverseWidth;

% Computing a normalised (i.e. variance = 1) kernel and gradient matrix for
% the inverse widths
K = exp(-0.5*invWidth1*invWidth2*(deltaT.^2)/(invWidth1+invWidth2));
gradK = sqrt((invWidth1+invWidth2)/(invWidth1*invWidth2)) ...
      - sqrt(invWidth1*invWidth2/(invWidth1+invWidth2)) * (deltaT.^2);

% Gradient w.r.t. the inverse widths
c = 0.5 * variance / (sqrt(2*pi)*((invWidth1+invWidth2)^2));
g1(1) = c * (invWidth2^2) * sum(sum(gradK .*  K .* covGrad));
g2(1) = c * (invWidth1^2) * sum(sum(gradK .*  K .* covGrad));

% Gradient w.r.t. sigma_r^2
c = sqrt((invWidth1*invWidth2)/(2*pi*(invWidth1+invWidth2)));
g1(2) = c * sum(sum(K .* covGrad));
g2(2) = 0; % Otherwise it is counted twice
