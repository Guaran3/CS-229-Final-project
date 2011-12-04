function [X, sigma2] = gplvmSppcaInit(Y, dims)

% GPLVMSPPCAINIT Initialise gplvm model with Scaled Probabilistic PCA.
%
%	Description:
%	[X, sigma2] = gplvmSppcaInit(Y, dims)
%% 	gplvmSppcaInit.m CVS version 1.2
% 	gplvmSppcaInit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

% Scale all Y values before doing probabilistic PCA.
for i = 1:size(Y, 2);
  va = var(Y(find(~isnan(Y(:, i))), i));
  if va ~= 0
    Y(:, i) = Y(:, i)/sqrt(va);
  end
end
[X, sigma2] = gplvmPpcaInit(Y, dims);
