function g = gpTimeDynamicsLogLikeGradients(model)

% GPTIMEDYNAMICSLOGLIKEGRADIENTS Gradients of the GP dynamics wrt parameters.
%
%	Description:
%
%	G = GPTIMEDYNAMICSLOGLIKEGRADIENTS(MODEL) Computes the gradients
%	with respect to the log likelihood of the GP dynamics in a GP-LVM
%	model.
%	 Returns:
%	  G - the gradients of the log likelihood with respect to the latent
%	   points and (optionally) parameters.
%	 Arguments:
%	  MODEL - the GP model for which log likelihood is to be computed.
%	
%
%	See also
%	GPLOGLIKEGRADIENTS, GPTIMEDYNAMICSCREATE, GPTIMEDYNAMICSLOGLIKELIHOOD, MODELLOGLIKELIHOOD


%	Copyright (c) 2006, 2009 Neil D. Lawrence
% 	gpTimeDynamicsLogLikeGradients.m CVS version 1.1
% 	gpTimeDynamicsLogLikeGradients.m SVN version 178
% 	last update 2009-01-08T13:58:54.000000Z

if model.k ==0 & ~model.learn & ~model.learnScales
  g = [];
  return
end

g = gpLogLikeGradients(model);

if ~model.learn
  % If we aren't learning model parameters extract only X_u;
  % this is inefficient (but neater in the code) as we have also computed parameters 
  if ~model.learnScales
    if isfield(model, 'fixInducing') & model.fixInducing
      g = [];
    else
      g = g(1:model.k*model.q);
    end
  else
    switch model.approx
     case 'ftc'
      g =  [g(end-model.d + 1:end)];
     case {'dtc', 'dtcvar', 'fitc', 'pitc'}
      if isfield(model, 'fixInducing') & model.fixInducing
        g = g(end-model.d:end-1);
      else
        g =  [g(1:model.k*model.q) g(end-model.d:end-1)];
      end
    end
  end
end
