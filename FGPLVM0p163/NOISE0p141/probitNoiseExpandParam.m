function noise = probitNoiseExpandParam(noise, params)

% PROBITNOISEEXPANDPARAM Create noise structure from PROBIT noise's parameters.
%
%	Description:
%
%	NOISE = PROBITNOISEEXPANDPARAM(NOISE, PARAM) returns a probit based
%	classification noise structure filled with the parameters in the
%	given vector. This is used as a helper function to enable parameters
%	to be optimised in, for example, the NETLAB optimisation functions.
%	 Returns:
%	  NOISE - noise structure with the given parameters in the relevant
%	   locations.
%	 Arguments:
%	  NOISE - the noise structure in which the parameters are to be
%	   placed.
%	  PARAM - vector of parameters which are to be placed in the noise
%	   structure.
%	
%
%	See also
%	PROBITNOISEPARAMINIT, PROBITNOISEEXTRACTPARAM, NOISEEXPANDPARAM


%	Copyright (c) 2004, 2005 Neil D. Lawrence
% 	probitNoiseExpandParam.m CVS version 1.4
% 	probitNoiseExpandParam.m SVN version 29
% 	last update 2007-11-03T14:29:05.000000Z


noise.bias = params(1:end);

