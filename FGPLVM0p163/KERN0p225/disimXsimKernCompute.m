function K = disimXsimKernCompute(disimKern, simKern, t1, t2)

% DISIMXSIMKERNCOMPUTE Compute a cross kernel between DISIM and SIM kernels.
%
%	Description:
%
%	K = DISIMXSIMKERNCOMPUTE(DISIMKERN, SIMKERN, T) computes cross
%	kernel terms between DISIM and SIM kernels for the multiple output
%	kernel.
%	 Returns:
%	  K - block of values from kernel matrix.
%	 Arguments:
%	  DISIMKERN - the kernel structure associated with the DISIM kernel.
%	  SIMKERN - the kernel structure associated with the SIM kernel.
%	  T - inputs for which kernel is to be computed.
%
%	K = DISIMXSIMKERNCOMPUTE(DISIMKERN, SIMKERN, T1, T2) computes cross
%	kernel terms between DISIM and SIM kernels for the multiple output
%	kernel.
%	 Returns:
%	  K - block of values from kernel matrix.
%	 Arguments:
%	  DISIMKERN - the kernel structure associated with the DISIM kernel.
%	  SIMKERN - the kernel structure associated with the SIM kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, DISIMKERNPARAMINIT, SIMKERNPARAMINIT


%	Copyright (c) 2006 Neil D. Lawrence
%	Copyright (c) 2007-2009 Antti Honkela
% 	disimXsimKernCompute.m CVS version 1.1
% 	disimXsimKernCompute.m SVN version 253
% 	last update 2009-02-21T08:55:59.000000Z

if nargin < 4
  t2 = t1;
end
if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
if disimKern.inverseWidth ~= simKern.inverseWidth
  error('Kernels cannot be cross combined if they have different inverse widths.')
end
if disimKern.di_decay ~= simKern.decay
  error('Kernels cannot be cross combined if they have different driving input decays.');
end
if disimKern.di_variance ~= simKern.variance
  error('Kernels cannot be cross combined if they have different driving input variances.');
end
if disimKern.rbf_variance ~= 1
  warning('KERN:simRBFVariance', ...
	  'Warning: copying non-unit RBF variance from DISIM to SIM kernel')
end

dim1 = size(t1, 1);
dim2 = size(t2, 1);
t1Mat = t1(:, ones(1, dim2));
t2Mat = t2(:, ones(1, dim1))';
diffT = (t1Mat - t2Mat);

l = sqrt(2/disimKern.inverseWidth);
D_i = disimKern.decay;
delta = disimKern.di_decay;

invLDiffT = 1/l*diffT;
halfLD_i = 0.5*l*D_i;
halfLDelta = 0.5*l*delta;

lnCommon1 = - log(2*delta) -delta * t2Mat - D_i * t1Mat + halfLDelta.^2;

lnFact1 = log(2 * delta) - log(delta^2 - D_i^2);
lnPart1 = lnDiffErfs(halfLDelta - t2Mat/l, halfLDelta);

lnFact2 = (D_i - delta) * t1Mat - log(delta - D_i);
lnPart2a = lnDiffErfs(halfLDelta, halfLDelta - t1Mat/l);
lnPart2b = lnDiffErfs(halfLDelta, halfLDelta - t2Mat/l);

lnFact3 = (D_i + delta) * t1Mat - log(delta + D_i);
lnPart3 = lnDiffErfs(halfLDelta + t1Mat/l, halfLDelta + invLDiffT);

lnFact4 = 2*delta*t2Mat + (D_i - delta) * t1Mat - log(delta - D_i);
lnPart4 = lnDiffErfs(halfLDelta - invLDiffT, halfLDelta + t2Mat/l);

lnCommon2 = - log(delta^2 - D_i^2) - delta * t2Mat - D_i * t1Mat + halfLD_i^2;
lnPart5 = lnDiffErfs(halfLD_i - t1Mat/l, halfLD_i);

lnFact6 = (D_i + delta) * t2Mat;
lnPart6 = lnDiffErfs(halfLD_i + t2Mat/l, halfLD_i - invLDiffT);

K = exp(lnCommon1 + lnFact1 + lnPart1) ...
    +exp(lnCommon1 + lnFact2 + lnPart2a) ...
    +exp(lnCommon1 + lnFact2 + lnPart2b) ...
    +exp(lnCommon1 + lnFact3 + lnPart3) ...
    +exp(lnCommon1 + lnFact4 + lnPart4) ...
    +exp(lnCommon2           + lnPart5) ...
    +exp(lnCommon2 + lnFact6 + lnPart6);
K = 0.5*K*sqrt(pi)*l;
K = disimKern.rbf_variance*disimKern.di_variance*sqrt(disimKern.variance)*K;
K = real(K);
