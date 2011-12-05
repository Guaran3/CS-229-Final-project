function [g, gParam] = fgplvmLogLikeGradients(model)

% FGPLVMLOGLIKEGRADIENTS Compute the gradients for the FGPLVM.
%
%	Description:
%
%	G = FGPLVMLOGLIKEGRADIENTS(MODEL) returns the gradients of the log
%	likelihood with respect to the parameters of the GP-LVM model and
%	with respect to the latent positions of the GP-LVM model.
%	 Returns:
%	  G - the gradients of the latent positions (or the back
%	   constraint's parameters) and the parameters of the GP-LVM model.
%	 Arguments:
%	  MODEL - the FGPLVM structure containing the parameters and the
%	   latent positions.
%
%	[GX, GPARAM] = FGPLVMLOGLIKEGRADIENTS(MODEL) returns the gradients
%	of the log likelihood with respect to the parameters of the GP-LVM
%	model and with respect to the latent positions of the GP-LVM model
%	in seperate matrices.
%	 Returns:
%	  GX - the gradients of the latent positions (or the back
%	   constraint's parameters).
%	  GPARAM - gradients of the parameters of the GP-LVM model.
%	 Arguments:
%	  MODEL - the FGPLVM structure containing the parameters and the
%	   latent positions.
%	
%	
%
%	See also
%	FGPLVMLOGLIKELIHOOD, FGPLVMCREATE, MODELLOGLIKEGRADIENTS


%	Copyright (c) 2005, 2006, 2009 Neil D. Lawrence


%	With modifications by Carl Henrik Ek 2009
% 	fgplvmLogLikeGradients.m CVS version 1.6
% 	fgplvmLogLikeGradients.m SVN version 536
% 	last update 2009-09-28T08:45:30.000000Z


[gParam, gX_u, gX] = gpLogLikeGradients(model);

if(isfield(model,'constraints')&&~isempty(model.constraints))
  for(i = 1:1:model.constraints.numConstraints)
    gX = gX + constraintLogLikeGradients(model.constraints.comp{i});
  end
end

gDynParam = [];
% Check if Dynamics kernel is being used.
if isfield(model, 'dynamics') && ~isempty(model.dynamics)

  % Get the dynamics parameters
  gDynParam = modelLogLikeGradients(model.dynamics);
  
  % Include the dynamics latent gradients.
  gX = gX + modelLatentGradients(model.dynamics);

elseif isfield(model, 'prior') &&  ~isempty(model.prior)
  gX = gX + priorGradient(model.prior, model.X); 
end

switch model.approx
 case {'dtc', 'dtcvar', 'fitc', 'pitc'}
  if isfield(model, 'inducingPrior') && ~isempty(model.inducingPrior)
    gX_u = gX_u + priorGradient(model.inducingPrior, model.X_u);
  end
 otherwise
  % do nothing
end

% Concatanate existing parameter gradients.
gParam = [gParam gDynParam];

% Decide where to include gX_u.
if ~strcmp(model.approx, 'ftc') & model.fixInducing
  gX(model.inducingIndices, :) = gX(model.inducingIndices, :) + gX_u;
else
  gParam = [gX_u(:)' gParam];
end

g_X_or_back = fgplvmBackConstraintGrad(model, gX);
if nargout>1
  g = g_X_or_back;
else
  g = [g_X_or_back(:)' gParam];
end



