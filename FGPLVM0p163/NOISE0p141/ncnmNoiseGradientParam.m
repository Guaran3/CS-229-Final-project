function g = ncnmNoiseGradientParam(noise, mu, varsigma, y)

% NCNMNOISEGRADIENTPARAM Gradient of parameters for NCNM.
%
%	Description:
%
%	G = NCNMNOISEGRADIENTPARAM(NOISE, MU, VARSIGMA, Y) Computes the
%	gradient of the log likelihood with respect to the null category
%	noise model's parameters.
%	 Returns:
%	  G - gradients of the log likelihood with respect to each of the
%	   parameters. See ncnmNoiseExtractParam for the ordering.
%	 Arguments:
%	  NOISE - structure containing the noise model.
%	  MU - input means to the noise model.
%	  VARSIGMA - input variances to the noise model.
%	  Y - target values for the noise model.
%	
%
%	See also
%	NCNMNOISEEXTRACTPARAM, NCNMNOISELOGLIKELIHOOD, NOISEGRADIENTPARAM


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	ncnmNoiseGradientParam.m CVS version 1.1
% 	ncnmNoiseGradientParam.m SVN version 29
% 	last update 2007-11-03T14:29:10.000000Z

D = size(y, 2);
for i = 1:D
  mu(:, i) = mu(:, i) + noise.bias(i);
end
c = 1./sqrt(noise.sigma2 + varsigma);
gnoise.bias = zeros(1, D);
gnoise.gammap = 0;
gnoise.gamman = 0;
epsilon = eps;
for j = 1:D
  % Do negative category first.
  index = find(y(:, j)==-1);
  if ~isempty(index)
    mu(index, j) = mu(index, j)+noise.width/2;
    u = mu(index, j).*c(index, j);
    gnoise.bias(j) = gnoise.bias(j) - sum(c(index, j).*gradLogCumGaussian(-u));
    gnoise.gamman = gnoise.gamman - length(index)/(1-noise.gamman);
  end

  % Do missing data.
  index = find(isnan(y(:, j)));
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.width/2;
    u = mu(index, j).*c(index, j);
    uprime = (mu(index, j) - noise.width).*c(index, j);
    lndenom = lnCumGaussSum(-u, uprime, noise.gamman, noise.gammap);
    lnNumer1 = log(noise.gamman) -.5*log(2*pi) -.5*(u.*u);
    lnNumer2 = log(noise.gammap) -.5*log(2*pi) -.5*(uprime.*uprime);
    B1 = exp(lnNumer1 - lndenom);
    B2 = exp(lnNumer2 - lndenom);
    gnoise.bias(j) = gnoise.bias(j) + sum(c(index, j).*(B2-B1));
    gnoise.gammap = gnoise.gammap + sum(exp(lnCumGaussian(uprime) -lndenom));
    gnoise.gamman = gnoise.gamman + sum(exp(lnCumGaussian(-u) - lndenom));
  end
  
  % Highest category
  index = find(y(:, j) == 1);
  if ~isempty(index)
    mu(index, j) = mu(index, j) - noise.width/2;
    mu(index, j) = mu(index, j).*c(index, j);
    addpart = sum(c(index, j).*gradLogCumGaussian(mu(index, j)));
    gnoise.bias(j) = gnoise.bias(j) + addpart;
    % 
    gnoise.gammap = gnoise.gammap - length(index)/(1-noise.gammap);
  end
end
if noise.gammaSplit
  g = [gnoise.bias gnoise.gamman(:)' gnoise.gammap(:)'];
else
  g = [gnoise.bias gnoise.gamman(:)' + gnoise.gammap(:)'];
end
%g = [gnoise.bias 0];
