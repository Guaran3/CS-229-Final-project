function [m, beta] = scaleNoiseSites(noise, g, nu, mu, varSigma, y)

% SCALENOISESITES Site updates for Scale noise model.
%
%	Description:
%	[m, beta] = scaleNoiseSites(noise, g, nu, mu, varSigma, y)
%% 	scaleNoiseSites.m CVS version 1.1
% 	scaleNoiseSites.m SVN version 29
% 	last update 2007-11-03T14:29:04.000000Z

N = size(y, 1);
D = length(noise.bias);
beta = zeros(N, D);
for i = 1:size(y, 2)
  m(:, i) = (y(:, i) - noise.bias(i))/noise.scale(i);
end
beta = repmat(1./noise.sigma2, N, D);
