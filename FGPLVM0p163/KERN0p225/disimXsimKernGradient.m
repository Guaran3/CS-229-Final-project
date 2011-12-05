function [g1, g2] = disimXsimKernGradient(disimKern, simKern, t1, t2, covGrad)

% DISIMXSIMKERNGRADIENT Compute gradient between the DISIM and SIM kernels.
%
%	Description:
%
%	[G1, G2] = DISIMXSIMKERNGRADIENT(DISIMKERN, SIMKERN, T) computes the
%	gradient of an objective function with respect to cross kernel terms
%	between DISIM and SIM kernels for the multiple output kernel.
%	 Returns:
%	  G1 - gradient of objective function with respect to kernel
%	   parameters of DISIM kernel.
%	  G2 - gradient of objective function with respect to kernel
%	   parameters of SIM kernel.
%	 Arguments:
%	  DISIMKERN - the kernel structure associated with the DISIM kernel.
%	  SIMKERN - the kernel structure associated with the SIM kernel.
%	  T - inputs for which kernel is to be computed.
%
%	[G1, G2] = DISIMXSIMKERNGRADIENT(DISIMKERN, SIMKERN, T1, T2)
%	computes the gradient of an objective function with respect to cross
%	kernel terms between DISIM and SIM kernels for the multiple output
%	kernel.
%	 Returns:
%	  G1 - gradient of objective function with respect to kernel
%	   parameters of DISIM kernel.
%	  G2 - gradient of objective function with respect to kernel
%	   parameters of SIM kernel.
%	 Arguments:
%	  DISIMKERN - the kernel structure associated with the DISIM kernel.
%	  SIMKERN - the kernel structure associated with the SIM kernel.
%	  T1 - row inputs for which kernel is to be computed.
%	  T2 - column inputs for which kernel is to be computed.
%	
%	
%
%	See also
%	MULTIKERNPARAMINIT, MULTIKERNCOMPUTE, SIMKERNPARAMINIT, RBFKERNPARAMINIT


%	Copyright (c) 2006 Neil D. Lawrence
%	Copyright (c) 2007-2009 Antti Honkela
% 	disimXsimKernGradient.m CVS version 1.1
% 	disimXsimKernGradient.m SVN version 253
% 	last update 2009-02-21T08:55:59.000000Z

arg{1} = t1;
if nargin < 5
  covGrad = t2;
  t2 = t1;
else
  arg{2} = t2;  
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

dim1 = size(t1, 1);
dim2 = size(t2, 1);
t1Mat = t1(:, ones(1, dim2));
t2Mat = t2(:, ones(1, dim1))';
diffT = (t1Mat - t2Mat);
l = sqrt(2/disimKern.inverseWidth);
l2 = l*l;
C_0 = sqrt(disimKern.di_variance);
C_i = sqrt(disimKern.variance);
C_r = disimKern.rbf_variance;

D_i = disimKern.decay;
delta = disimKern.di_decay;
halfLD_i = 0.5*l*D_i;
halfLDelta = 0.5*l*delta;
invLDiffT = 1/l*diffT;


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

K1 = exp( lnCommon1 + lnFact1 + lnPart1) ...
     +exp(lnCommon1 + lnFact2 + lnPart2a) ...
     +exp(lnCommon1 + lnFact2 + lnPart2b) ...
     +exp(lnCommon1 + lnFact3 + lnPart3) ...
     +exp(lnCommon1 + lnFact4 + lnPart4);

K2 = exp( lnCommon2           + lnPart5) ...
     +exp(lnCommon2 + lnFact6 + lnPart6);

prefact = 0.5*sqrt(pi)*l*disimKern.rbf_variance*disimKern.di_variance*sqrt(disimKern.variance);
K = prefact*real(K1+K2);

%Kp = disimXsimKernCompute(disimKern, simKern, arg{:});
%K - Kp

dcommon1 = - 1 ./ delta - t2Mat + l * halfLDelta;
dfact1 = 1 ./ delta - 2 * delta ./ (delta^2 - D_i^2);
dfact2 = -t1Mat - 1./(delta - D_i);
dfact3 = t1Mat - 1./(delta + D_i);
dfact4 = 2*t2Mat - t1Mat - 1./(delta - D_i);
dcommon2 = - 2 * delta ./ (delta^2 - D_i^2) - t2Mat;
dfact6 = t2Mat;

[dpart1, m1] = gradLnDiffErfs(halfLDelta - t2Mat/l, halfLDelta, ...
					 l/2, l/2);
[dpart2a, m2a] = gradLnDiffErfs(halfLDelta, halfLDelta - t1Mat/l, ...
					   l/2, l/2);
[dpart2b, m2b] = gradLnDiffErfs(halfLDelta, halfLDelta - t2Mat/l, ...
					   l/2, l/2);
[dpart3, m3] = gradLnDiffErfs(halfLDelta + t1Mat/l, halfLDelta + invLDiffT, ...
					 l/2, l/2);
[dpart4, m4] = gradLnDiffErfs(halfLDelta - invLDiffT, halfLDelta + t2Mat/l, ...
					 l/2, l/2);

dK_ddelta = prefact * ...
    (dcommon1 .* K1 + dcommon2 .* K2 ...
     + dfact1 .* exp(lnCommon1 + lnFact1 + lnPart1) ...
     + dfact2 .* exp(lnCommon1 + lnFact2 + lnPart2a) ...
     + dfact2 .* exp(lnCommon1 + lnFact2 + lnPart2b) ...
     + dfact3 .* exp(lnCommon1 + lnFact3 + lnPart3) ...
     + dfact4 .* exp(lnCommon1 + lnFact4 + lnPart4) ...
     + dfact6 .* exp(lnCommon2 + lnFact6 + lnPart6) ...
     + dpart1 .* exp(lnCommon1 + lnFact1 - m1) ...
     + dpart2a .* exp(lnCommon1 + lnFact2 - m2a) ...
     + dpart2b .* exp(lnCommon1 + lnFact2 - m2b) ...
     + dpart3 .* exp(lnCommon1 + lnFact3 - m3) ...
     + dpart4 .* exp(lnCommon1 + lnFact4 - m4));


dcommon1 = delta * halfLDelta;
dcommon2 = D_i * halfLD_i;

[dpart1, m1] = gradLnDiffErfs(halfLDelta - t2Mat/l, halfLDelta, ...
			      delta/2 + t2Mat/l2, delta/2);
[dpart2a, m2a] = gradLnDiffErfs(halfLDelta, halfLDelta - t1Mat/l, ...
				delta/2, delta/2 + t1Mat/l2);
[dpart2b, m2b] = gradLnDiffErfs(halfLDelta, halfLDelta - t2Mat/l, ...
				delta/2, delta/2 + t2Mat/l2);
[dpart3, m3] = gradLnDiffErfs(halfLDelta + t1Mat/l, halfLDelta + invLDiffT, ...
			      delta/2 - t1Mat/l2, delta/2 - invLDiffT/l);
[dpart4, m4] = gradLnDiffErfs(halfLDelta - invLDiffT, halfLDelta + t2Mat/l, ...
			      delta/2 + invLDiffT/l, delta/2 - t2Mat/l2);
[dpart5, m5] = gradLnDiffErfs(halfLD_i - t1Mat/l, halfLD_i, ...
			      D_i/2 + t1Mat/l2, D_i/2);
[dpart6, m6] = gradLnDiffErfs(halfLD_i + t2Mat/l, halfLD_i - invLDiffT, ...
			      D_i/2 - t2Mat/l2, D_i/2 + invLDiffT/l);

dK_dl = real(prefact ...
	     .* (dcommon1 .* K1 + dcommon2 .* K2 ...
		 +dpart1 .* exp(lnCommon1 + lnFact1 - m1) ...
		 +dpart2a .* exp(lnCommon1 + lnFact2 - m2a) ...
		 +dpart2b .* exp(lnCommon1 + lnFact2 - m2b) ...
		 +dpart3 .* exp(lnCommon1 + lnFact3 - m3) ...
		 +dpart4 .* exp(lnCommon1 + lnFact4 - m4) ...
		 +dpart5 .* exp(lnCommon2           - m5) ...
		 +dpart6 .* exp(lnCommon2 + lnFact6 - m6))) ...
	+ K / l;


dcommon1 = - t1Mat;
dfact1 = 2 * D_i ./ (delta^2 - D_i^2);
dfact2 = t1Mat + 1./(delta - D_i);
dfact3 = t1Mat - 1./(delta + D_i);
dfact4 = t1Mat + 1./(delta - D_i);
dcommon2 = 2 * D_i ./ (delta^2 - D_i^2) - t1Mat + l*halfLD_i;
dfact6 = t2Mat;

[dpart5, m5] = gradLnDiffErfs(halfLD_i - t1Mat/l, halfLD_i, ...
			      l/2, l/2);
[dpart6, m6] = gradLnDiffErfs(halfLD_i + t2Mat/l, halfLD_i - invLDiffT, ...
			      l/2, l/2);


dK_dD = prefact ...
	.* (dcommon1 .* K1 + dcommon2 .* K2 ...
	    + dfact1 .* exp(lnCommon1 + lnFact1 + lnPart1) ...
	    + dfact2 .* exp(lnCommon1 + lnFact2 + lnPart2a) ...
	    + dfact2 .* exp(lnCommon1 + lnFact2 + lnPart2b) ...
	    + dfact3 .* exp(lnCommon1 + lnFact3 + lnPart3) ...
	    + dfact4 .* exp(lnCommon1 + lnFact4 + lnPart4) ...
	    + dfact6 .* exp(lnCommon2 + lnFact6 + lnPart6) ...
	    + dpart5 .* exp(lnCommon2           - m5) ...
	    + dpart6 .* exp(lnCommon2 + lnFact6 - m6));

dk_ddelta = sum(sum(dK_ddelta.*covGrad));
dk_dl = sum(sum(dK_dl.*covGrad));
dk_dD = sum(sum(dK_dD.*covGrad));


dk_dRBFVariance = sum(sum(K.*covGrad))/disimKern.rbf_variance;
dk_dDIVariance = sum(sum(K.*covGrad))/disimKern.di_variance;
dk_dSimVariance = .5 * sum(sum(K.*covGrad))/disimKern.variance;

dk_dinvWidth = -0.5*sqrt(2)/(disimKern.inverseWidth* ...
                             sqrt(disimKern.inverseWidth))*dk_dl;


% only pass the gradient with respect to the inverse width to one
% of the gradient vectors ... otherwise it is counted twice.
g1 = real([dk_ddelta dk_dinvWidth dk_dDIVariance dk_dD dk_dSimVariance dk_dRBFVariance]);
g2 = [0 0 0];
