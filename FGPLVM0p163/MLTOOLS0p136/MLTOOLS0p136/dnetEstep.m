function model = dnetEstep(model, Ypred)

% DNETESTEP Do an E-step (update importance weights) on an Density Network model.
%
%	Description:
%
%	MODEL = DNETESTEP(MODEL) updates the importance weights (or
%	posterior responsibilities) for a Density Network model.
%	 Returns:
%	  MODEL - the model with updated weights.
%	 Arguments:
%	  MODEL - the model which is to be updated.
%
%	MODEL = DNETESTEP(MODEL, YPRED) updates the importance weights (or
%	posterior responsibilities) for a Density Network model.
%	 Returns:
%	  MODEL - the model with updated weights.
%	 Arguments:
%	  MODEL - the model which is to be updated.
%	  YPRED - model predictions at the mixture component centres.
%	
%
%	See also
%	DNETCREATE, DNETMSTEP


%	Copyright (c) 2008 Neil D. Lawrence
% 	dnetEstep.m SVN version 536
% 	last update 2009-09-30T15:10:27.000000Z

  diffVal = zeros(model.N, model.M);
  if nargin < 2
    Ypred = dnetOut(model, model.X_u);
  end
  if model.N > model.M
    for k = 1:model.M
      diffY = model.y - repmat(Ypred(k, :), model.N, 1);
      diffVal(:, k) = -0.5*sum(diffY.*diffY, 2)*model.beta;
    end
  else
    for i = 1:model.N
      diffY = repmat(model.y(i, :), model.M, 1) - Ypred;
      diffVal(i, :) = -0.5*sum(diffY.*diffY, 2)'*model.beta;
    end
  end
  diffVal = diffVal - repmat(max(diffVal, [], 2), 1, model.M);
  w = exp(diffVal);
  w = w./repmat(sum(w, 2), 1, model.M);
  model.w = sparse(w);
  model.X = model.w*model.X_u;
end