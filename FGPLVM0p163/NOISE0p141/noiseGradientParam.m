function g = noiseGradientParam(noise, mu, varsigma, y)

% NOISEGRADIENTPARAM Gradient wrt the noise model's parameters.
%
%	Description:
%
%	G = NOISEGRADIENTPARAM(NOISE, MU, VARSIGMA, Y) computes the gradient
%	of the log Z of the given noise model with respect to the of
%	functions with respect to the given noise model's parameters.
%	 Returns:
%	  G - gradients of the log probability with respect to the noise
%	   parameters. The ordering of the vector should match that provided
%	   by the function noiseExtractParam.
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
%	% SEEALSO NOISECREATE, NOISEPARAMINIT, NOISEGRADVALS, NOISEGRADIENTPARAM


%	Copyright (c) 2004, 2005 Neil D. Lawrence
% 	noiseGradientParam.m CVS version 1.5
% 	noiseGradientParam.m SVN version 29
% 	last update 2007-11-03T14:29:07.000000Z

fhandle = str2func([noise.type 'NoiseGradientParam']);
g = fhandle(noise, mu, varsigma, y);

% check if there is a prior over parameters
if isfield(noise, 'priors')
  for i = 1:length(noise.priors)
    index = noise.priors(i).index;
    g(index) = g(index) + priorGradient(noise.priors(i), params(index));
  end
end

% Check if parameters are being optimised in a transformed space.
if isfield(noise, 'transforms')
  fhandle = str2func([noise.type 'NoiseExtractParam']);
  params = fhandle(noise);
  for i = 1:length(noise.transforms)
    index = noise.transforms(i).index;
    fhandle = str2func([noise.transforms(i).type 'Transform']);
    g(index) = g(index).*fhandle(params(index), 'gradfact');
  end
end