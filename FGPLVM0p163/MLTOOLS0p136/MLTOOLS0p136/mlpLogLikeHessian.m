function g = mlpLogLikeHessian(model)

% MLPLOGLIKEHESSIAN Multi-layer perceptron Hessian.
%
%	Description:
%
%	G = MLPLOGLIKEHESSIAN(MODEL) computes the Hessian of the log
%	likelihood of a multi-layer perceptron with respect to the
%	parameters. For networks with a single hidden layer this is done by
%	wrapping the mlpgrad command.
%	 Returns:
%	  G - the Hessian of the model log likelihood.
%	 Arguments:
%	  MODEL - the model structure for computing the log likelihood.
%	
%
%	See also
%	MODELLOGLIKEIHOOD, MLPGRAD


%	Copyright (c) 2006, 2007 Neil D. Lawrence
% 	mlpLogLikeHessian.m CVS version 1.2
% 	mlpLogLikeHessian.m SVN version 24
% 	last update 2007-03-04T23:36:18.000000Z

if length(model.hiddenDim)==1
  g = -mlphess(model, model.X, model.y);
else
  error('Hessian not yet available for this model.')
end
