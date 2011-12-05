function [mu, varsigma] = ivmPosteriorMeanVar(model, X);

% IVMPOSTERIORMEANVAR Mean and variances of the posterior at points given by X.
%
%	Description:
%
%	[MU, SIGMA] = IVMPOSTERIORMEANVAR(MODEL, X) returns the posterior
%	mean and variance for a given set of points.
%	 Returns:
%	  MU - the mean of the posterior distribution.
%	  SIGMA - the variances of the posterior distributions.
%	 Arguments:
%	  MODEL - the model for which the posterior will be computed.
%	  X - the input positions for which the posterior will be computed.
%	
%
%	See also
%	IVMCREATE, IVMPOSTERIORGRADMEANVAR


%	Copyright (c) 2004, 2005 Neil D. Lawrence
% 	ivmPosteriorMeanVar.m version 1.12


D = size(model.y, 2);
numData = size(X, 1);

varsigma = zeros(numData, D);
mu = zeros(numData, D);

% Compute kernel for new point.
kX = kernCompute(model.kern, X, model.X(model.I, :))';

% Compute diagonal of kernel for new point.
diagK = kernDiagCompute(model.kern, X);

if length(model.Sigma) > 1
  for i = 1:D
    Lk = model.Sigma(i).Linv*kX;
    Kinvk = model.Sigma(i).Linv'*Lk;
    for n = 1:numData
      varsigma(n, i) = diagK(n) - Lk(:, n)'*Lk(:, n); 
      if any(varsigma(n, :) < 0)
        warning('Varsigma less than zero');
      end
    end
    mu(:, i) = Kinvk'*model.m(model.I, i);
  end
else
  Lk = model.Sigma.Linv*kX;
  Kinvk = model.Sigma.Linv'*Lk;
  for n = 1:numData
    varsigma(n, :) = repmat(diagK(n) - Lk(:, n)'*Lk(:, n), 1, D);
    if varsigma(n, 1) < 0
      warning('Varsigma less than zero');
    end
  end
  mu = Kinvk'*full(model.m(model.I, :));
end
