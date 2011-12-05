function noise = ncnmNoiseParamInit(noise, y)

% NCNMNOISEPARAMINIT null category noise model's parameter initialisation.
%
%	Description:
%	The null category noise model enables semi-supervised learning
%	with Gaussian processes. The approach is described in a 2004 NIPS
%	paper by Lawrence and Jordan.
%	
%
%	NOISE = NCNMNOISEPARAMINIT(NOISE, Y) initialises the parameters of
%	the null category noise model.
%	 Returns:
%	  NOISE - the initialised noise structure.
%	 Arguments:
%	  NOISE - the structure to initialise.
%	  Y - a set of target values.
%
%	NOISE = NCNMNOISEPARAMINIT(NOISE) initialises the parameters of the
%	null category noise model.
%	 Returns:
%	  NOISE - the initialised noise structure.
%	 Arguments:
%	  NOISE - the structure to initialise.
%	
%
%	See also
%	NOISEPARAMINIT, NOISECREATE


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	ncnmNoiseParamInit.m CVS version 1.1
% 	ncnmNoiseParamInit.m SVN version 29
% 	last update 2007-11-03T14:29:07.000000Z

% The likelihood is not log concave.
noise.logconcave = 0;
noise.gammaSplit = 0;

if nargin > 1
  nClass1 = sum(y==1, 1);
  nClass2 = sum(y==-1, 1);
  totClass = nClass1 + nClass2;
  p1 = nClass1./totClass;
  noise.numProcess = size(y, 2);
  noise.gamman = sum(isnan(y))/length(y);
  noise.gammap = noise.gamman;
  noise.bias = invCumGaussian(p1);
else
  noise.bias = zeros(1, noise.numProcess);
  noise.gamman = 0.5;
  noise.gammap = 0.5;
end
if noise.gammaSplit
  noise.nParams = noise.numProcess+2;
else
  noise.nParams = noise.numProcess+1;
end

% Constrain noise.prior to be between 0 and 1.
if noise.gammaSplit
  noise.transforms.index = [noise.numProcess+1 noise.numProcess+2];
else
  noise.transforms.index = [noise.numProcess+1];
end
noise.transforms.type = optimiDefaultConstraint('zeroone');

% This isn't optimised, it sets the gradient of the erf.
noise.sigma2 = eps;

% Can handle missing values?
noise.missing = 1;
noise.width = 1;
