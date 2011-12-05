function [params, transform] = sqexpKernExtractParam(kern)

% SQEXPKERNEXTRACTPARAM Extract parameters from the SQEXP kernel structure.
%
%	Description:
%
%	PARAM = SQEXPKERNEXTRACTPARAM(KERN) Extract parameters from the
%	pre-built compound squared exponential kernel structure into a
%	vector of parameters for optimisation.
%	 Returns:
%	  PARAM - vector of parameters extracted from the kernel. If the
%	   field 'transforms' is not empty in the kernel matrix, the
%	   parameters will be transformed before optimisation (for example
%	   positive only parameters could be logged before being returned).
%	 Arguments:
%	  KERN - the kernel structure containing the parameters to be
%	   extracted.
%	DESC Extract parameters and parameter names from the pre-built
%	compound squared exponential kernel structure.
%	ARG kern : the kernel structure containing the parameters to be
%	extracted.
%	RETURN param : vector of parameters extracted from the kernel. If
%	the field 'transforms' is not empty in the kernel matrix, the
%	parameters will be transformed before optimisation (for example
%	positive only parameters could be logged before being returned).
%	RETURN names : celly array of strings containing parameter names.
%	
%	
%	
%
%	See also
%	% SEEALSO SQEXPKERNPARAMINIT, SQEXPKERNEXPANDPARAM, KERNEXTRACTPARAM, SCG, CONJGRAD


%	Copyright (c) 2004 Neil D. Lawrence
% 	sqexpKernExtractParam.m CVS version 1.4
% 	sqexpKernExtractParam.m SVN version 1
% 	last update 2006-10-25T10:53:01.000000Z

params = [kern.inverseWidth kern.rbfVariance kern.biasVariance ...
          kern.whiteVariance];
if nargout > 1
  names{1} = 'sqexp inverse width';
  names{2} = 'sqexp rbf variance';
  names{3} = 'sqexp bias variance';
  names{4} = 'sqexp white variance';
end
