function k = disimKernDiagCompute(kern, t)

% DISIMKERNDIAGCOMPUTE Compute diagonal of DISIM kernel.
%
%	Description:
%
%	K = DISIMKERNDIAGCOMPUTE(KERN, T) computes the diagonal of the
%	kernel matrix for the driven input single input motif kernel given a
%	design matrix of inputs.
%	 Returns:
%	  K - a vector containing the diagonal of the kernel matrix computed
%	   at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  T - input data matrix in the form of a design matrix.
%	
%	
%
%	See also
%	DISIMKERNPARAMINIT, KERNDIAGCOMPUTE, KERNCREATE, DISIMKERNCOMPUTE


%	Copyright (c) 2006 Neil D. Lawrence
%	Copyright (c) 2007-2008 Antti Honkela
% 	disimKernDiagCompute.m CVS version 1.1
% 	disimKernDiagCompute.m SVN version 163
% 	last update 2009-01-08T09:55:06.000000Z

if size(t, 2) > 1 
  error('Input can only have one column');
end

l = sqrt(2/kern.inverseWidth);
t = t;
delta = kern.di_decay;
D = kern.decay;
halfLD = 0.5*l*D;
halfLDelta = 0.5*l*delta;

lnPart1 = lnDiffErfs(halfLDelta - t/l, ...
		     halfLDelta);
lnPart2 = lnDiffErfs(halfLDelta + t/l, ...
		     halfLDelta);

lnCommon = halfLDelta .^ 2 -(D+delta)*t - log(2*delta) - log(D-delta);
lnFact2 = (D+delta)*t - log(D + delta);


if abs(D-delta) < .1,
  h = exp(lnCommon + lnPart1) ...
      .* ((exp((D-delta)*t) - 1) / (D - delta) + 1/(D+delta)) ...
      + exp(lnCommon + lnFact2 + lnPart2);
else
  lnFact1a = (D - delta) * t + log(D + delta) - log(D^2 - delta^2);
  lnFact1b = log(2*delta) - log(D^2 - delta^2);

  h = exp(lnCommon + lnFact1a + lnPart1) ...
      - exp(lnCommon + lnFact1b + lnPart1) ...
      + exp(lnCommon + lnFact2 + lnPart2);
end

lnPart1p = lnDiffErfs(halfLD - t/l, ...
		      halfLD);
lnPart2p = lnDiffErfs(halfLD + t/l, ...
		      halfLD);

lnCommonp = halfLD.^2 - 2*D*t - log(delta^2 - D^2);
lnFact2p = 2*D*t - log(2*D);

if abs(D-delta) < .1,
  hp = exp(lnCommonp + lnPart1p) ...
       .* ((exp((D-delta)*t) - 1) / (D - delta) + 1/(2*D)) ...
       + exp(lnCommonp + lnFact2p + lnPart2p);
else
  lnFact1ap = log(D + delta) - log(delta - D) - log(2*D);
  lnFact1bp = (D-delta)*t - log(delta - D);

  hp = exp(lnCommonp + lnFact1ap + lnPart1p) ...
       - exp(lnCommonp + lnFact1bp + lnPart1p) ...
       + exp(lnCommonp + lnFact2p + lnPart2p);
end

k = 2*real(h+hp);
k = 0.5*k*sqrt(pi)*l;
k = kern.rbf_variance*kern.di_variance*kern.variance*k;
