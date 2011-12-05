function ll = fgplvmLogLikelihood(model)

% FGPLVMLOGLIKELIHOOD Log-likelihood for a GP-LVM.
%
%	Description:
%
%	LL = FGPLVMLOGLIKELIHOOD(MODEL) returns the log likelihood for a
%	given GP-LVM model.
%	 Returns:
%	  LL - the log likelihood of the data given the model.
%	 Arguments:
%	  MODEL - the model for which the log likelihood is to be computed.
%	   The model contains the data for which the likelihood is being
%	   computed in the 'y' component of the structure.
%	
%	
%	
%
%	See also
%	GPLOGLIKELIHOOD, FGPLVMCREATE


%	Copyright (c) 2005, 2006, 2009 Neil D. Lawrence


%	With modifications by Carl Henrik Ek 2008, 2009
% 	fgplvmLogLikelihood.m CVS version 1.5
% 	fgplvmLogLikelihood.m SVN version 291
% 	last update 2009-03-04T22:08:40.000000Z
 
ll = gpLogLikelihood(model);

if isfield(model, 'dynamics') && ~isempty(model.dynamics)
  % A dynamics model is being used.
  ll = ll + modelLogLikelihood(model.dynamics);
elseif isfield(model, 'prior') &&  ~isempty(model.prior)
  for i = 1:model.N
    ll = ll + priorLogProb(model.prior, model.X(i, :));
  end
end

switch model.approx
  case {'dtc', 'dtcvar', 'fitc', 'pitc'}
   if isfield(model, 'inducingPrior') && ~isempty(model.inducingPrior)
     for i = 1:model.k
       ll = ll + priorLogProb(model.inducingPrior, model.X_u(i, :));    
     end
   end
 otherwise
  % do nothing
end

if(isfield(model,'constraints')&&~isempty(model.constraints))
  for(i = 1:1:model.constraints.numConstraints)
    ll = ll - constraintLogLikelihood(model.constraints.comp{i},model.X);
  end
end

