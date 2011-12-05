function noise = orderedNoiseParamInit(noise, y)

% ORDEREDNOISEPARAMINIT ORDERED noise parameter initialisation.
%
%	Description:
%	The ordered categorical noise model is an ordinal regression noise
%	model. The real line is divided into categories, which have some
%	ordering (such as small, medium, large).
%	
%
%	NOISE = ORDEREDNOISEPARAMINIT(NOISE) initialises the ordered
%	categorical noise structure with some default parameters.
%	 Returns:
%	  NOISE - the noise structure with the default parameters placed in.
%	 Arguments:
%	  NOISE - the noise structure which requires initialisation.
%	
%
%	See also
%	NOISECREATE, NOISEPARAMINIT


%	Copyright (c) 2004, 2005 Neil D. Lawrence
% 	orderedNoiseParamInit.m CVS version 1.4
% 	orderedNoiseParamInit.m SVN version 29
% 	last update 2007-11-03T14:29:05.000000Z


if nargin > 1
  noise.C = max(max(y))+1;
  noise.numProcess = size(y, 2);
  noise.bias = zeros(1, noise.numProcess);
  for i = 1:size(y, 2)
    noise.bias(i) = mean(y(find(~isnan(y(:, i))), i));
  end
else
  noise.bias = repmat(1/2, 1, noise.numProcess);
end
noise.nParams = noise.C-2 + noise.numProcess;

if noise.C > 2
  noise.widths = repmat(1/(noise.C-2), noise.C-2, 1);
  noise.transforms.index = [noise.numProcess+1:noise.nParams];
  noise.transforms.type = optimiDefaultConstraint('positive');
else 
  noise.widths = [];
end
noise.variance = 0.1; % needs to be set a bit above zero for numerical reasons.

% Can handle missing values?
noise.missing = 1;

