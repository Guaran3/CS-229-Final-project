function [X, sigma2] = kpcaEmbed(Y, dims)

% KPCAEMBED Embed data set with kernel PCA.
%
%	Description:
%	[X, sigma2] = kpcaEmbed(Y, dims)
%% 	kpcaEmbed.m CVS version 1.1
% 	kpcaEmbed.m SVN version 24
% 	last update 2005-12-18T12:26:22.000000Z


if any(any(isnan(Y)))
  error('When missing data is present Kernel PCA cannot be used to initialise')
end

K = kernCompute(kern, Y);
[u, v] = eigs(K, dims);
X = u*sqrt(v);
sigma2 = -1;