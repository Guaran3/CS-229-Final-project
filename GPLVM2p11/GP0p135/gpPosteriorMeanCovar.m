function [mu, covarSigma, factors] = gpPosteriorMeanCovar(model, X);

% GPPOSTERIORMEANCOVAR Mean and covariances of the posterior at points given by X.
%
%	Description:
%
%	[MU, SIGMA] = GPPOSTERIORMEANCOVAR(MODEL, X) gives the posterior
%	mean and covariance at the points given by X.
%	 Returns:
%	  MU - the posterior mean.
%	  SIGMA - the posterior covariance.
%	 Arguments:
%	  MODEL - the model for which the posterior will be computed.
%	  X - the latent positions where the mean and covariance will be
%	   computed.
%
%	[MU, SIGMA, FACTOR] = GPPOSTERIORMEANCOVAR(MODEL, X) gives the
%	posterior mean and covariance at the points given by X without
%	scaling on the output posterior covariance. This allows for a more
%	compact representation. The scale factors are provided in a separate
%	vector FACTORS.
%	 Returns:
%	  MU - the posterior mean.
%	  SIGMA - the posterior covariance *without scaling*.
%	  FACTOR - the factors to multiply each dimension by to obtain the
%	   covariances for each output.
%	 Arguments:
%	  MODEL - the model for which the posterior will be computed.
%	  X - the latent positions where the mean and covariance will be
%	   computed.
%	
%
%	See also
%	GPCREATE, GPPOSTERIORMEANVAR


%	Copyright (c) 2006, 2009 Neil D. Lawrence
% 	gpPosteriorMeanCovar.m CVS version 1.3
% 	gpPosteriorMeanCovar.m SVN version 178
% 	last update 2009-01-08T13:48:37.000000Z

% Just call gpPosteriorMeanVar for means.
mu = gpPosteriorMeanVar(model, X);

if nargout > 1
  if size(X, 1)>1000
    warning(['Computation of covariances takes a long time for larger ' ...
             'data sets, are you sure you did''nt just want ' ...
             'variances? If so use gpPosteriorMeanVar.'])
  end
end

% Compute kernel for new point.
switch model.approx
 case 'ftc'
  KX_star = kernCompute(model.kern, model.X, X);  
 case {'dtc', 'dtcvar', 'fitc', 'pitc'}
  KX_star = kernCompute(model.kern, model.X_u, X);  
end

% Compute covariances if requried.
if nargout > 1
  % Compute kernel for new point.
  K = kernCompute(model.kern, X);
  if ~model.isMissingData
    switch model.approx
     case 'ftc'
      Kinvk = model.invK_uu*KX_star;
     case {'dtc', 'dtcvar', 'fitc', 'pitc'}
      Kinvk = (model.invK_uu - (1/model.beta)*model.Ainv)*KX_star;
    end
    
    covarsig = K - KX_star'*Kinvk;
    if isfield(model, 'beta')
      covarsig = covarsig + eye(size(X, 1))*(1/model.beta);
    end
    if nargout>2
      covarSigma = covarsig;
      factors = model.scale.*model.scale;
    else
      for i = 1:model.d
        covarSigma{i} = covarsig*model.scale(i)*model.scale(i);
      end
    end
  else
    for i = 1:model.d
      switch model.approx
       case 'ftc'
        Kinvk{i} = model.invK_uu{i}*KX_star;
       case {'dtc', 'dtcvar', 'fitc', 'pitc'}
        Kinvk{i} = (model.invK_uu - (1/model.beta)*model.Ainv{i})*KX_star;
      end      
      covarsig{i} = K - KX_star'*Kinvk{i};
      if isfield(model, 'beta')
        covarsig{i} = covarsig{i} + eye(size(X, 1))*(1/model.beta);
      end
      if nargout>2
        error(['Cannot return covariance and scales with models ' ...
               'trained on missing data.'])
      else
        covarSigma{i} = covarsig{i}*model.scale(i)*model.scale(i);
      end
    end
  end
end 
