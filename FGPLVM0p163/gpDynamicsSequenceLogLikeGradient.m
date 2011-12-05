function gX = gpDynamicsSequenceLogLikeGradient(model, Xraw,varargin)

% GPDYNAMICSSEQUENCELOGLIKEGRADIENT Log-likelihood gradient for of a sequence of the GP-LVM dynamics.
%
%	Description:
%
%	G = GPDYNAMICSSEQUENCELOGLIKEGRADIENT(MODEL, X) returns the gradient
%	of the log likelihood with respect to the latent position, where the
%	log likelihood is conditioned on the training set latent points.
%	 Returns:
%	  G - the gradient of the log likelihood, conditioned on the
%	   training data, with respect to the latent sequence.
%	 Arguments:
%	  MODEL - the model for which the gradient computation is being
%	   done.
%	  X - the latent sequence where the gradient is being computed.
%	
%	
%
%	See also
%	GPDYNAMICSSEQUENCELOGLIKELIHOOD, FGPLVMOPTIMISESEQUENCE, FGPLVMSEQUENCELOGLIKEGRADIENT


%	Copyright (c) 2006 Neil D. Lawrence
%	Copyright (c) 2008 Carl Henrik Ek
% 	gpDynamicsSequenceLogLikeGradient.m CVS version 1.2
% 	gpDynamicsSequenceLogLikeGradient.m SVN version 761
% 	last update 2010-04-13T14:06:02.000000Z

if(isfield(model,'indexIn')&&~isempty(model.indexIn)&&length(model.indexIn)~=size(Xraw,2))
  Xraw = Xraw(:,model.indexIn);
end

ind_in = 1:size(Xraw, 1)-1;
ind_out = 2:size(Xraw, 1);

X = Xraw(ind_in, :);
if model.diff
  Y = Xraw(ind_out, :) - X;
else
  Y = Xraw(ind_out, :);
end

gX = zeros(size(Xraw, 1), size(Xraw, 2));

gDynX = gpSequenceLogLikeGradient(model, X, Y);
[mu, covar, factors] = gpPosteriorMeanCovar(model, X);
invCovar = pdinv(covar);
Ydiff= Y - mu;
% Deal with the fact that X appears in the *target* for the dynamics.
for i =1:model.q
  gX(ind_out, i) = gX(ind_out, i) - 1/(factors(i))*invCovar*Ydiff(:, i);
  if model.diff
    gX(ind_in, i) = gX(ind_in, i) + 1/(factors(i))*invCovar*Ydiff(:, i);
  end
end
 


gX(ind_in,:) = gX(ind_in,:) + gDynX;

% If there is a prior field, use it on the first point in the sequence
if isfield(model, 'prior') &  ~isempty(model.prior)
  gX(1,:) = gX(1,:) + priorGradient(model.prior, model.X(1,:));
end

tmp = zeros(size(gX,1),length(model.indexAll));
tmp(:,model.indexOut) = gX;
gX = tmp;

return
