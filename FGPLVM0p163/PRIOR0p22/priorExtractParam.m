function [params, names] = priorExtractParam(prior)

% PRIOREXTRACTPARAM Extract the prior model's parameters.
%
%	Description:
%
%	PARAM = PRIOREXTRACTPARAM(PRIOR) Extract parameters from the prior
%	into a vector of parameters for optimisation.
%	 Returns:
%	  PARAM - vector of parameters extracted from the prior. If the
%	   field 'transforms' is not empty in the prior, the parameters will
%	   be transformed before optimisation (for example positive only
%	   parameters could be logged before being returned).
%	 Arguments:
%	  PRIOR - the prior structure containing the parameters to be
%	   extracted.
%	
%
%	See also
%	PRIOREXPANDPARAM, SCG, CONJGRAD


%	Copyright (c) 2003, 2004, 2005 Neil D. Lawrence
% 	priorExtractParam.m CVS version 1.5
% 	priorExtractParam.m SVN version 29
% 	last update 2008-03-21T17:42:58.000000Z

fhandle = str2func([prior.type 'PriorExtractParam']);
if nargout < 2
  params = fhandle(prior);
else
  [params, names] = fhandle(prior);
end


% Check if parameters are being optimised in a transformed space.
if isfield(prior, 'transforms')
  for i = 1:length(prior.transforms)
    index = prior.transforms(i).index;
    fhandle = str2func([prior.transforms(i).type 'Transform']);
    params(index) = fhandle(params(index), 'xtoa');
  end
end