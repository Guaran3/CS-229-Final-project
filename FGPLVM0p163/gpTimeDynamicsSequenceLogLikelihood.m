function ll = gpTimeDynamicsSequenceLogLikelihood(model, latentValsRaw, t)

% GPTIMEDYNAMICSSEQUENCELOGLIKELIHOOD Return the log likelihood of a given latent sequence.
%
%	Description:
%
%	LL = GPTIMEDYNAMICSSEQUENCELOGLIKELIHOOD(MODEL, X, T) returns a log
%	likelihood for a latent sequence given a dynamics model and a set of
%	training data.
%	 Returns:
%	  LL - the log probability of the latent sequence given the training
%	   data and the model.
%	 Arguments:
%	  MODEL - the model containing the dynamics model for which the log
%	   likelihood is to be computed.
%	  X - the latent positions of the sequence for which the log
%	   likelihood is to be computed.
%	  T - the times in the sequence for which the log likelihood is to
%	   be computed.
%	
%	
%
%	See also
%	FGPLVMSEQUENCELOGLIKELIHOOD, GPTIMEDYNAMICSCREATE


%	Copyright (c) 2006 Neil D. Lawrence


%	With modifications by Carl Henrik Ek 2008
% 	gpTimeDynamicsSequenceLogLikelihood.m CVS version 1.1
% 	gpTimeDynamicsSequenceLogLikelihood.m SVN version 82
% 	last update 2008-09-12T09:31:42.000000Z


if nargin < 3
  t = [2:size(latentValsRaw, 1)]';
  warning('No time inputs provided for gpTimeDynamicsSequenceLogLikelihood')
end
startVal=1;
if(isfield(model,'indexIn')&&~isempty(model.indexIn))
  latentValsRaw = latentValsRaw(:,model.indexIn);
end
latentVals = latentValsRaw(1:end-1, :);

if model.diff
  Y = latentValsRaw(2:end, :) - latentVals;
else
  Y = latentValsRaw(2:end, :);
end

logTwoPi = log(2*pi);
[mu, covarSigma, factors] = gpPosteriorMeanCovar(model, t);
U = jitChol(covarSigma);
Ydiff = (Y-mu);
ll = 0;
UinvYdiff = U'\Ydiff;
logDet = logdet([], U);
for i = 1:model.d
  ll = ll + logDet + log(factors(i)) + (UinvYdiff(:, i)'*UinvYdiff(:, ...
                                                    i))/factors(i);
  ll = ll + logTwoPi*size(Y, 1);
end
ll = -0.5*ll;

% Perhaps should be running prior on first point here.