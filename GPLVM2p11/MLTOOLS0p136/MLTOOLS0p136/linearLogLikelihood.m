function ll = linearLogLikelihood(model)

% LINEARLOGLIKELIHOOD Linear model log likelihood.
%
%	Description:
%
%	LL = LINEARLOGLIKELIHOOD(MODEL) computes the log likelihood of a
%	linear model.
%	 Returns:
%	  LL - the model log likelihood.
%	 Arguments:
%	  MODEL - the model structure for computing the log likelihood.
%	
%
%	See also
%	MODELLOGLIKEIHOOD, MLPERR


%	Copyright (c) 2006 Neil D. Lawrence
% 	linearLogLikelihood.m CVS version 1.1
% 	linearLogLikelihood.m SVN version 24
% 	last update 2006-06-07T10:45:27.000000Z

N = size(model.y, 1);
centred = model.y - repmat(model.b, N, 1) - model.X* ...
       model.W;

centred = centred*model.beta;
ll = N*model.outputDim*(log(model.beta) - log(2*pi)) - sum(sum(centred.*centred))* ...
     model.beta;
ll = ll*0.5;