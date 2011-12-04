function [X, sigma2] = gplvmPpcaInit(Y, dims)

% GPLVMPPCAINIT Initialise gplvm model with probabilistic PCA.
%
%	Description:
%	[X, sigma2] = gplvmPpcaInit(Y, dims)
%% 	gplvmPpcaInit.m CVS version 1.2
% 	gplvmPpcaInit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

if ~any(any(isnan(Y)))
  [sigma2, u, v] = ppca(cov(Y), dims);
  v(find(v<0))=0;
  Ymean = mean(Y);
  Ycentre = zeros(size(Y));
  for i = 1:size(Y, 2);
    Ycentre(:, i) = Y(:, i) - Ymean(i);
  end
  X = Ycentre*u(:, 1:dims)*diag(1./sqrt(v(1:dims)));
else
  % Hacky implementation of EM for Probabilistic PCA for when there is missing data.
  iters = 100;
  % Initialise W randomly
  d = size(Y, 2);
  q = dims;
  N = size(Y, 1);
  W = randn(d, q)*1e-3;
  sigma2 = 1;
  mu = zeros(d, 1);
  for i = 1:d
    obs = ~isnan(Y(:, i));
    mu(i) = mean(Y(find(obs), i));
  end
  numObs = sum(sum(~isnan(Y)));
  for i = 1:iters
    M = W'*W + sigma2*eye(q);
    invM = inv(M);
    exp_xxT = zeros(q);
    exp_x = zeros(N, q);
    for n = 1:N
      obs = find(~isnan(Y(n, :)));
      exp_x(n, :) = (invM*W(obs, :)'*(Y(n, obs)' - mu(obs)))';
    end
    exp_xxT = N*sigma2*invM + exp_x'*exp_x;
    s = zeros(d, q);
    s2 = 0;
    for n = 1:N
      obs = find(~isnan(Y(n, :)));
      subY = zeros(size(Y(n, :)))';
      subY(obs) = Y(n, obs)' - mu(obs);
      s = s + (subY)*exp_x(n, :);
      s2 = s2 + sum((Y(n, obs)' - mu(obs)).^2) - 2*exp_x(n, :)*W(obs, :)'*(Y(n, obs)' - mu(obs));
    end
    W = s*inv(exp_xxT);
    sigma2 = 1/(numObs)*(s2 + trace(exp_xxT*W'*W));
  end
  
  X = exp_x;
end