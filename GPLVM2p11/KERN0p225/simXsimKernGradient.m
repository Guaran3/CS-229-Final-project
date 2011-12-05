function [g1, g2] = simXsimKernGradient(simKern1, simKern2, t1, t2, covGrad)

% SIMXSIMKERNGRADIENT Compute a cross gradient between two SIM kernels.
%
%	Description:
%
%	[G1, G2] = SIMXSIMKERNGRADIENT(SIMKERN1, SIMKERN2, T, COVGRAD)
%	computes cross gradient of parameters of a cross kernel between two
%	sim kernels for the multiple output kernel.
%	 Returns:
%	  G1 - gradient of the parameters of the first kernel, for ordering
%	   see simKernExtractParam.
%	  G2 - gradient of the parameters of the second kernel, for ordering
%	   see simKernExtractParam.
%	 Arguments:
%	  SIMKERN1 - the kernel structure associated with the first SIM
%	   kernel.
%	  SIMKERN2 - the kernel structure associated with the second SIM
%	   kernel.
%	  T - inputs for which kernel is to be computed.
%	  COVGRAD - gradient of the objective function with respect to the
%	   elements of the cross kernel matrix.
%
%	[G1, G2] = SIMXSIMKERNGRADIENT(SIMKERN1, SIMKERN2, T1, T2, COVGRAD)
%	computes cross kernel terms between two SIM kernels for the multiple
%	output kernel.
%	 Returns:
%	  G1 - gradient of the parameters of the first kernel, for ordering
%	   see simKernExtractParam.
%	  G2 - gradient of the parameters of the second kernel, for ordering
%	   see simKernExtractParam.
%	 Arguments:
%	  SIMKERN1 - the kernel structure associated with the first SIM
%	   kernel.
%	  SIMKERN2 - the kernel structure associated with the second SIM
%	   kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	  COVGRAD - gradient of the objective function with respect to the
%	   elements of the cross kernel matrix.
%	
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, SIMKERNPARAMINIT, SIMKERNEXTRACTPARAM


%	Copyright (c) 2006 Neil D. Lawrence


%	With modifications by David Luengo 2009
% 	simXsimKernGradient.m CVS version 1.3
% 	simXsimKernGradient.m SVN version 618
% 	last update 2009-11-28T15:31:04.000000Z

arg{1}=t1;
if nargin < 5
  covGrad = t2;
  t2 = t1;
else
  arg{2}=t2;
end
if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
if simKern1.inverseWidth ~= simKern2.inverseWidth
  error('Kernels cannot be cross combined if they have different inverse widths.')
end
% The normalisation in the SIM kernel arises from the use of the normalised
% version of the RBF kernel. Hence, both have to be normalised or not.
if ~isfield(simKern1, 'isNormalised')
    isSim1Normalised = false;
else
    isSim1Normalised = simKern1.isNormalised;
end
if ~isfield(simKern2, 'isNormalised')
    isSim2Normalised = false;
else
    isSim2Normalised = simKern2.isNormalised;
end
if isSim1Normalised ~= isSim2Normalised
    error('Both SIM kernels have to be either normalised or not.');
end

sigma = sqrt(2/simKern1.inverseWidth);
if (simKern1.isStationary == false || simKern2.isStationary == false)
    [h1, dh1_dD1, dh1_dD2, dh1_dsigma] = ...
        simComputeH(t1, t2, simKern1.decay, simKern2.decay, simKern1.delay, simKern2.delay, sigma);
else
    [h1, dh1_dD1, dh1_dD2, dh1_dsigma] = ...
        simComputeHStat(t1, t2, simKern1.decay, simKern2.decay, simKern1.delay, simKern2.delay, sigma);
end

% Avoid making the expensive call twice unless really necessary
if ((length(t1) == length(t2)) && all(t1 == t2) && ...
    (simKern1.decay == simKern2.decay) && (simKern1.delay == simKern2.delay)),
  h2 = h1;
  dh2_dD2 = dh1_dD1;
  dh2_dD1 = dh1_dD2;
  dh2_dsigma = dh1_dsigma;
elseif (simKern1.isStationary == false) || (simKern2.isStationary == false)
  [h2, dh2_dD2, dh2_dD1, dh2_dsigma] = ...
      simComputeH(t2, t1, simKern2.decay, simKern1.decay, simKern2.delay, simKern1.delay, sigma);
else
    [h2, dh2_dD2, dh2_dD1, dh2_dsigma] = ...
        simComputeHStat(t2, t1, simKern2.decay, simKern1.decay, simKern2.delay, simKern1.delay, sigma);
end
dK_dD1 = dh1_dD1 + dh2_dD1';
dK_dD2 = dh1_dD2 + dh2_dD2';
dK_dsigma = dh1_dsigma + dh2_dsigma';

if isfield(simKern1, 'isNegativeS') && (simKern1.isNegativeS == true)
    C1 = simKern1.variance;
    C2 = simKern2.variance;
else
    C1 = sqrt(simKern1.variance);
    C2 = sqrt(simKern2.variance);
end

K = 0.5 * (h1 + h2');
var2 = C1*C2;
if ~isSim1Normalised
    K = sqrt(pi) * K;
    dk_dD1 = (sum(sum(covGrad.*dh1_dD1)) + sum(sum(covGrad.*dh2_dD1')))*0.5*sqrt(pi)*sigma*var2;
    dk_dD2 = (sum(sum(covGrad.*dh1_dD2)) + sum(sum(covGrad.*dh2_dD2')))*0.5*sqrt(pi)*sigma*var2;
    dk_dsigma = sum(sum(covGrad.*(dK_dsigma*0.5*sqrt(pi)*sigma + K)))*var2;
    dk_dC1 = sigma * C2 * sum(sum(covGrad.*K));
    dk_dC2 = sigma * C1 * sum(sum(covGrad.*K));
else
    dk_dD1 = (sum(sum(covGrad.*dh1_dD1)) + sum(sum(covGrad.*dh2_dD1')))*0.5*var2;
    dk_dD2 = (sum(sum(covGrad.*dh1_dD2)) + sum(sum(covGrad.*dh2_dD2')))*0.5*var2;
    dk_dsigma = 0.5 * var2 * sum(sum(covGrad.*dK_dsigma));
    dk_dC1 = C2 * sum(sum(covGrad.*K));
    dk_dC2 = C1 * sum(sum(covGrad.*K));
end


if isfield(simKern1, 'isNegativeS') && (simKern1.isNegativeS == true)
    dk_dSim1Variance = dk_dC1;
    dk_dSim2Variance = dk_dC2;
else
    dk_dSim1Variance = dk_dC1*0.5/C1;
    dk_dSim2Variance = dk_dC2*0.5/C2;
end

dk_dinvWidth = -0.5*sqrt(2)/(simKern1.inverseWidth* ...
                             sqrt(simKern1.inverseWidth))*dk_dsigma;

% only pass the gradient with respect to the inverse width to one
% of the gradient vectors ... otherwise it is counted twice.
g1 = real([dk_dD1 dk_dinvWidth dk_dSim1Variance]);
g2 = real([dk_dD2 0 dk_dSim2Variance]);
