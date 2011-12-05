function [g1, g2] = lfmwhiteXlfmwhiteKernGradient(lfmKern1, lfmKern2, t1, varargin)

% LFMWHITEXLFMWHITEKERNGRADIENT Compute a cross gradient between two
%
%	Description:
%	LFM-WHITE kernels.
%
%	[G1, G2] = LFMWHITEXLFMWHITEKERNGRADIENT(LFMKERN1, LFMKERN2, T1,
%	COVGRAD) computes cross gradient of parameters of a cross kernel
%	between two LFM-WHITE kernels for the multiple output kernel.
%	 Returns:
%	  G1 - gradient of the parameters of the first kernel, for ordering
%	   see lfmwhiteKernExtractParam.
%	  G2 - gradient of the parameters of the second kernel, for ordering
%	   see lfmwhiteKernExtractParam.
%	 Arguments:
%	  LFMKERN1 - the kernel structure associated with the first
%	   LFM-WHITE kernel.
%	  LFMKERN2 - the kernel structure associated with the second
%	   LFM-WHITE kernel.
%	  T1 - inputs for which kernel is to be computed.
%	  COVGRAD - gradient of the objective function with respect to the
%	   elements of the cross kernel matrix.
%
%	[G1, G2] = LFMWHITEXLFMWHITEKERNGRADIENT(LFMKERN1, LFMKERN2, T1, T2,
%	COVGRAD) computes cross kernel terms between two LFM-WHITE kernels
%	for the multiple output kernel.
%	 Returns:
%	  G1 - gradient of the parameters of the first kernel, for ordering
%	   see lfmwhiteKernExtractParam.
%	  G2 - gradient of the parameters of the second kernel, for ordering
%	   see lfmwhiteKernExtractParam.
%	 Arguments:
%	  LFMKERN1 - the kernel structure associated with the first
%	   LFM-WHITE kernel.
%	  LFMKERN2 - the kernel structure associated with the second
%	   LFM-WHITE kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	  COVGRAD - gradient of the objective function with respect to the
%	   elements of the cross kernel matrix.
%	lfmwhiteKernExtractParam
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, LFMWHITEKERNPARAMINIT, 


%	Copyright (c) 2009 David Luengo
% 	lfmwhiteXlfmwhiteKernGradient.m SVN version 306
% 	last update 2009-04-09T10:36:31.000000Z


if nargin < 5
    t2 = t1;
else
    t2 = varargin{1};
end
covGrad = varargin{end};

if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
if lfmKern1.variance ~= lfmKern2.variance
  error('Kernels cannot be cross combined if they have different variances.')
end

g1 = zeros(1, lfmKern1.nParams);
g2 = zeros(1, lfmKern1.nParams);

T1 = repmat(t1, 1, size(t2, 1));
T2 = repmat(t2.', size(t1, 1), 1);
ind = (T1 >= T2);

% Terms needed later in the gradients

mass1 = lfmKern1.mass;
spring1 = lfmKern1.spring;
damper1 = lfmKern1.damper;
sensitivity1 = lfmKern1.sensitivity;
alpha1 = lfmKern1.alpha;
omega1 = lfmKern1.omega;
gamma1 = lfmKern1.gamma;
gamma1Tilde = alpha1 - j*omega1;
isStationary1 = lfmKern1.isStationary;

mass2 = lfmKern2.mass;
spring2 = lfmKern2.spring;
damper2 = lfmKern2.damper;
sensitivity2 = lfmKern2.sensitivity;
alpha2 = lfmKern2.alpha;
omega2 = lfmKern2.omega;
gamma2 = lfmKern2.gamma;
gamma2Tilde = alpha2 - j*omega2;
isStationary2 = lfmKern2.isStationary;

variance = lfmKern1.variance;

c = 1 / (4 * mass1 * mass2 * omega1 * omega2);

lfmKern1.variance = 1;
lfmKern1.sensitivity = 1;
lfmKern2.variance = 1;
lfmKern2.sensitivity = 1;
K = lfmwhiteXlfmwhiteKernCompute(lfmKern1, lfmKern2, t1, t2);

gradMass = [1 0 0];
gradAlpha1 = [-damper1/(2*mass1^2) 1/(2*mass1) 0];
gradAlpha2 = [-damper2/(2*mass2^2) 1/(2*mass2) 0];
c21 = sqrt(4*mass1*spring1-damper1^2);
gradOmega1 = [(damper1^2-2*mass1*spring1)/(2*c21*mass1^2) ...
    -damper1/(2*c21*mass1) 1/c21];
c22 = sqrt(4*mass2*spring2-damper2^2);
gradOmega2 = [(damper2^2-2*mass2*spring2)/(2*c22*mass2^2) ...
    -damper2/(2*c22*mass2) 1/c22];

% Gradient w.r.t. m_p and m_q
g1(1) = variance * sensitivity1 * sensitivity2 ...
    * sum(sum((c * (lfmwhiteComputeGradThetaH2(gamma2, gamma1Tilde, t1, t2, ...
        gradAlpha1(1) - j*gradOmega1(1), isStationary1, isStationary2) ...
    + lfmwhiteComputeGradThetaH2(gamma2Tilde, gamma1, t1, t2, ...
        gradAlpha1(1) + j*gradOmega1(1), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH2(gamma2Tilde, gamma1Tilde, t1, t2, ...
        gradAlpha1(1) - j*gradOmega1(1), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH2(gamma2, gamma1, t1, t2, ...
        gradAlpha1(1) + j*gradOmega1(1), isStationary1, isStationary2)) ...
    - (gradMass(1)/mass1 + gradOmega1(1)/omega1) * K) .* covGrad));
g2(1) = variance * sensitivity1 * sensitivity2 ...
    * sum(sum((c * (lfmwhiteComputeGradThetaH1(gamma2, gamma1Tilde, t1, t2, ...
        gradAlpha2(1) + j*gradOmega2(1), isStationary1, isStationary2) ...
    + lfmwhiteComputeGradThetaH1(gamma2Tilde, gamma1, t1, t2, ...
        gradAlpha2(1) - j*gradOmega2(1), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH1(gamma2Tilde, gamma1Tilde, t1, t2, ...
        gradAlpha2(1) - j*gradOmega2(1), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH1(gamma2, gamma1, t1, t2, ...
        gradAlpha2(1) + j*gradOmega2(1), isStationary1, isStationary2)) ...
    - (gradMass(1)/mass2 + gradOmega2(1)/omega2) * K) .* covGrad));

% Gradient w.r.t. D_p and D_q
g1(2) = variance * sensitivity1 * sensitivity2 ...
    * sum(sum(( c * (lfmwhiteComputeGradThetaH2(gamma2, gamma1Tilde, t1, t2, ...
        gradAlpha1(3) - j*gradOmega1(3), isStationary1, isStationary2) ...
    + lfmwhiteComputeGradThetaH2(gamma2Tilde, gamma1, t1, t2, ...
        gradAlpha1(3) + j*gradOmega1(3), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH2(gamma2Tilde, gamma1Tilde, t1, t2, ...
        gradAlpha1(3) - j*gradOmega1(3), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH2(gamma2, gamma1, t1, t2, ...
        gradAlpha1(3) + j*gradOmega1(3), isStationary1, isStationary2)) ...
    - (gradMass(3)/mass1 + gradOmega1(3)/omega1) * K) .* covGrad));
g2(2) = variance * sensitivity1 * sensitivity2 ...
    * sum(sum(( c * (lfmwhiteComputeGradThetaH1(gamma2, gamma1Tilde, t1, t2, ...
        gradAlpha2(3) + j*gradOmega2(3), isStationary1, isStationary2) ...
    + lfmwhiteComputeGradThetaH1(gamma2Tilde, gamma1, t1, t2, ...
        gradAlpha2(3) - j*gradOmega2(3), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH1(gamma2Tilde, gamma1Tilde, t1, t2, ...
        gradAlpha2(3) - j*gradOmega2(3), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH1(gamma2, gamma1, t1, t2, ...
        gradAlpha2(3) + j*gradOmega2(3), isStationary1, isStationary2)) ...
    - (gradMass(3)/mass2 + gradOmega2(3)/omega2) * K) .* covGrad));

% Gradient w.r.t. C_p and C_q
g1(3) = variance * sensitivity1 * sensitivity2 ...
    * sum(sum(( c * (lfmwhiteComputeGradThetaH2(gamma2, gamma1Tilde, t1, t2, ...
        gradAlpha1(2) - j*gradOmega1(2), isStationary1, isStationary2) ...
    + lfmwhiteComputeGradThetaH2(gamma2Tilde, gamma1, t1, t2, ...
        gradAlpha1(2) + j*gradOmega1(2), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH2(gamma2Tilde, gamma1Tilde, t1, t2, ...
        gradAlpha1(2) - j*gradOmega1(2), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH2(gamma2, gamma1, t1, t2, ...
        gradAlpha1(2) + j*gradOmega1(2), isStationary1, isStationary2)) ...
    - (gradMass(2)/mass1 + gradOmega1(2)/omega1) * K) .* covGrad));
g2(3) = variance * sensitivity1 * sensitivity2 ...
    * sum(sum(( c * (lfmwhiteComputeGradThetaH1(gamma2, gamma1Tilde, t1, t2, ...
        gradAlpha2(2) + j*gradOmega2(2), isStationary1, isStationary2) ...
    + lfmwhiteComputeGradThetaH1(gamma2Tilde, gamma1, t1, t2, ...
        gradAlpha2(2) - j*gradOmega2(2), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH1(gamma2Tilde, gamma1Tilde, t1, t2, ...
        gradAlpha2(2) - j*gradOmega2(2), isStationary1, isStationary2) ...
    - lfmwhiteComputeGradThetaH1(gamma2, gamma1, t1, t2, ...
        gradAlpha2(2) + j*gradOmega2(2), isStationary1, isStationary2)) ...
    - (gradMass(2)/mass2 + gradOmega2(2)/omega2) * K) .* covGrad));

% Gradient w.r.t. sigma_r^2
g1(4) = sensitivity1 * sensitivity2 * sum(sum(K .* covGrad));
g2(4) = 0; % Otherwise it is counted twice

% Gradient w.r.t. S_{pr} and S_{qr}
g1(5) = variance * sensitivity2 * sum(sum(K .* covGrad));
g2(5) = variance * sensitivity1 * sum(sum(K .* covGrad));

% Ensuring that the gradients are real
g1 = real(g1);
g2 = real(g2);
