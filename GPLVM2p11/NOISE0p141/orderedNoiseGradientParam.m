function g = orderedNoiseGradientParam(noise, mu, varsigma, y)

% ORDEREDNOISEGRADIENTPARAM Gradient of ORDERED noise's parameters.
%
%	Description:
%
%	G = ORDEREDNOISEGRADIENTPARAM(NOISE, MU, VARSIGMA, Y) computes the
%	gradient of the log Z of the ordered categorical noise model with
%	respect to the of functions with respect to the ordered categorical
%	noise's parameters.
%	 Returns:
%	  G - gradients of the log Z with respect to the noise parameters.
%	   The ordering of the vector should match that provided by the
%	   function noiseExtractParam.
%	 Arguments:
%	  NOISE - the noise structure for which the gradients are being
%	   computed.
%	  MU - the input means for which the gradients are being computed.
%	  VARSIGMA - the input variances for which the gradients are being
%	   computed.
%	  Y - the target values for the noise model.
%	
%	
%
%	See also
%	% SEEALSO ORDEREDNOISEPARAMINIT, ORDEREDNOISEGRADVALS, NOISEGRADIENTPARAM


%	Copyright (c) 2004, 2005 Neil D. Lawrence
% 	orderedNoiseGradientParam.m CVS version 1.4
% 	orderedNoiseGradientParam.m SVN version 29
% 	last update 2007-11-03T14:29:07.000000Z


D = size(y, 2);
c = 1./sqrt(noise.variance + varsigma);
gnoise.bias = zeros(1, D);
gnoise.widths = zeros(noise.C-2, 1);
for j = 1:D
  % Do lowest category first
  index = find(y(:, j)==0);
  if ~isempty(index)
    mu(index, j) = mu(index, j) + noise.bias(j) ;
    mu(index, j) = mu(index, j).*c(index, j);
    gnoise.bias(j) = gnoise.bias(j) - sum(c(index, j).*gradLogCumGaussian(-mu(index, j)));
  end

  % Intermediate categories
  index = find(y(:, j)>0 & y(:, j) <noise.C-1);
  if ~isempty(index)
    for i = index'
      mu(i, j) = mu(i, j) + noise.bias(j) - sum(noise.widths(1:y(i, j)-1));
    end
    u = mu(index, j).*c(index, j);
    uprime = (mu(index, j) - noise.widths(y(index, j))).*c(index, j);
    B1 = gaussOverDiffCumGaussian(u, uprime, 1);   
    B2 = gaussOverDiffCumGaussian(u, uprime, 2);
    gnoise.bias(j) = gnoise.bias(j) + sum(c(index, j).*(B1 - B2));
    for cat = 1:noise.C-2
      
      subIndex = find(y(index, j) == cat);
      if ~isempty(subIndex)
        addpart = sum(c(index(subIndex), j)...
                      .*B2(subIndex));
        gnoise.widths(1:cat) = gnoise.widths(1:cat) ...
            + repmat(addpart, cat, 1);
        if(cat > 1)
          addpart = sum(c(index(subIndex), j)...
                        .*B1(subIndex));
          gnoise.widths(1:cat-1) = gnoise.widths(1:cat-1) ...
              - repmat(addpart, cat-1, 1);
        end
      end
    end
  end
  
  % Highest category
  index = find(y(:, j) == noise.C-1);
  if ~isempty(index)
    for i = index'
      mu(i, j) = mu(i, j) + noise.bias(j) - sum(noise.widths(1:y(i, j)-1));
    end
    mu(index, j) = mu(index, j).*c(index, j);
    addpart = sum(c(index, j).*gradLogCumGaussian(mu(index, j)));
    gnoise.bias(j) = gnoise.bias(j) + addpart;
    if length(noise.widths > 0)
      gnoise.widths = gnoise.widths ...
          - repmat(addpart, noise.C-2, 1);
    end
  end
end
if length(noise.widths>0)
  g = [gnoise.bias gnoise.widths(:)'];
else
  g = gnoise.bias;
end
