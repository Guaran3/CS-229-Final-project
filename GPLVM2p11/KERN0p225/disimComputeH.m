function [h, dh_ddelta, dh_dD_j, dh_dD_k, dh_dl] = disimComputeH(t1, t2, delta, D_j, D_k, l)

% DISIMCOMPUTEH Helper function for comptuing part of the DISIM kernel.
%
%	Description:
%
%	H = DISIMCOMPUTEH(T1, T2, DECAY0, DECAY1, DECAY2, L) computes a
%	portion of the DISIM kernel.
%	 Returns:
%	  H - result of this subcomponent of the kernel for the given
%	   values.
%	 Arguments:
%	  T1 - first time input (number of time points x 1).
%	  T2 - second time input (number of time points x 1).
%	  DECAY0 - Decay rate for the driving system.
%	  DECAY1 - Decay rate for first system.
%	  DECAY2 - Decay rate for second system.
%	  L - length scale of latent process.
%	DESC computes a portion of the DISIM kernel and gradients with
%	respect to various parameters.
%	ARG t1 : first time input (number of time points x 1).
%	ARG t2 : second time input (number of time points x 1).
%	ARG decay0 : Decay rate for the driving system.
%	ARG decay1 : Decay rate for first system.
%	ARG decay2 : Decay rate for second system.
%	ARG l : length scale of latent process.
%	RETURN h : result of this subcomponent of the kernel for the given values.
%	RETURN grad_D_decay0 : gradient of H with respect to DECAY0.
%	RETURN grad_D_decay1 : gradient of H with respect to DECAY1.
%	RETURN grad_D_decay2 : gradient of H with respect to DECAY2.
%	RETURN grad_L : gradient of H with respect to length scale of
%	latent process.
%	
%	
%	
%	
%
%	See also
%	DISIMKERNPARAMINIT, DISIMCOMPUTEHPRIME


%	Copyright (c) 2006 Neil D. Lawrence
%	Copyright (c) 2007-2008 Antti Honkela


%	With modifications by  
% 	disimComputeH.m CVS version 1.1
% 	disimComputeH.m SVN version 166
% 	last update 2009-01-08T09:55:06.000000Z

if size(t1, 2) > 1 | size(t2, 2) > 1
  error('Input can only have one column');
end
dim1 = size(t1, 1);
dim2 = size(t2, 1);
t1 = t1;
t2 = t2;
t1Mat = t1(:, ones(1, dim2));
t2Mat = t2(:, ones(1, dim1))';
diffT = (t1Mat - t2Mat);
invLDiffT = 1/l*diffT;
halfLDelta = 0.5*l*delta;
h = zeros(size(t1Mat));

[lnPart1, sign1] = lnDiffErfs(halfLDelta - t1Mat/l, ...
			      halfLDelta);
[lnPart2, sign2] = lnDiffErfs(halfLDelta + t2Mat/l, ...
			      halfLDelta - invLDiffT);

lnCommon = halfLDelta.^2 - log(2*delta)...
    - D_k * t2Mat - delta * t1Mat - log(D_j - delta);

lnFact1a1 = log(D_k + delta) + (D_k-delta)*t2Mat;
lnFact1a2 = log(2*delta);
lnFact1b = log(D_k^2 - delta^2);

lnFact2a = (D_k + delta) * t2Mat;
lnFact2b = log(D_k + delta);

if abs(D_k - delta) < .1,
%  h = exp(lnCommon) .* ...
%      (exp(lnFact1a1 - lnFact1b + lnPart1) ...
%       - exp(lnFact1a2 - lnFact1b + lnPart1)) ...
%      + exp(lnCommon + lnFact2a - lnFact2b + lnPart2);
  h = sign1 .* exp(lnCommon + lnPart1) .* ...
      ((exp((D_k-delta)*t2Mat) - 1) / (D_k - delta) + 1/(D_k+delta)) ...
      + sign2 .* exp(lnCommon + lnFact2a - lnFact2b + lnPart2);
else
  h = sign1 .* exp(lnCommon + lnFact1a1 - lnFact1b + lnPart1) ...
      - sign1 .* exp(lnCommon + lnFact1a2 - lnFact1b + lnPart1) ...
      + sign2 .* exp(lnCommon + lnFact2a - lnFact2b + lnPart2);
end

h = real(h);

l2 = l*l;

if nargout > 1
  m1 = min((halfLDelta - t1Mat/l).^2, halfLDelta.^2);
  m2 = min((halfLDelta + t2Mat/l).^2, (halfLDelta - invLDiffT).^2);
  %dlnPart1 = l/sqrt(pi) * (exp(-(halfLDelta - t1Mat/l).^2) ...
  %			   - exp(-halfLDelta.^2));
  %dlnPart2 = l/sqrt(pi) * (exp(-(halfLDelta + t2Mat/l).^2) ...
  %			   - exp(-(halfLDelta - invLDiffT).^2));
  dlnPart1 = l/sqrt(pi) * (exp(-(halfLDelta - t1Mat/l).^2 + m1) ...
  			   - exp(-halfLDelta.^2 + m1));
  dlnPart2 = l/sqrt(pi) * (exp(-(halfLDelta + t2Mat/l).^2 + m2) ...
  			   - exp(-(halfLDelta - invLDiffT).^2 + m2));
  dh_ddelta = (l * halfLDelta - t1Mat + 1./(D_j - delta) - 1/delta) .* h ...
      + exp(lnCommon + lnFact1a1 - lnFact1b - m1) .* dlnPart1 ...
      - exp(lnCommon + lnFact1a2 - lnFact1b - m1) .* dlnPart1 ...
      + exp(lnCommon + lnFact2a - lnFact2b - m2) .* dlnPart2 ...
      + sign1 .* exp(lnCommon + lnPart1 + lnFact1a1 - lnFact1b) ...
      .* (1./(D_k - delta) - t2Mat) ...
      - sign1 .* exp(lnCommon + lnPart1 ...
	    + log(2 * (D_k^2 + delta^2)) ...
	    - 2 * lnFact1b) ...
      + (t2Mat - 1./(D_k + delta)) ...
      .* sign2 .* exp((D_k + delta) * t2Mat + lnCommon + lnPart2 ...
	     - log(D_k + delta));
  dh_ddelta = real(dh_ddelta);
  if nargout > 2
    dh_dD_j = real(- 1./(D_j - delta) .* h);
    if nargout > 3
      dh_dD_k = -t2Mat .* h ...
		+ sign1 .* exp(lnCommon + lnPart1 + lnFact1a1 - lnFact1b) ...
		.* (t2Mat - 1./(D_k - delta)) ...
		- sign1 .* exp(lnCommon + lnPart1) ...
		.* (-4*delta*D_k / (D_k^2 - delta^2)^2) ...
		+ (t2Mat - 1./(D_k + delta)) ...
		.* sign2 .* exp(lnFact2a - lnFact2b + lnCommon + lnPart2);
      dh_dD_k = real(dh_dD_k);
      if nargout > 4
	dh_dl = exp(lnCommon + lnFact1a1 - lnFact1b - m1) ...
		.* ((delta/sqrt(pi) + 2*t1Mat/(l2*sqrt(pi))) ...
		    .* exp(-(halfLDelta - t1Mat/l).^2 + m1) ...
		    - (delta/sqrt(pi) * exp(-halfLDelta.^2 + m1))) ...
		-exp(lnCommon + lnFact1a2 - lnFact1b - m1) ...
		.* ((delta/sqrt(pi) + 2*t1Mat/(l2*sqrt(pi))) ...
		    .* exp(-(halfLDelta - t1Mat/l).^2 + m1) ...
		    - (delta/sqrt(pi) * exp(-halfLDelta.^2 + m1))) ...
		+exp(lnCommon + lnFact2a - lnFact2b - m2) ...
		.* ((delta/sqrt(pi) - 2*t2Mat/(l2*sqrt(pi))) ...
		    .* exp(-(halfLDelta + t2Mat/l).^2 + m2) ...
		    - ((delta/sqrt(pi) + 2*invLDiffT/(l*sqrt(pi))) ...
		       .* exp(-(halfLDelta - invLDiffT).^2 + m2))) ...
		+ delta*halfLDelta*h;
	dh_dl = real(dh_dl);
      end
    end
  end
end
