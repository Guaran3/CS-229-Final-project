function [params, names] = mlpardKernExtractParam(kern)

% MLPARDKERNEXTRACTPARAM Extract parameters from the MLPARD kernel structure.
%
%	Description:
%
%	PARAM = MLPARDKERNEXTRACTPARAM(KERN) Extract parameters from the
%	automatic relevance determination multi-layer perceptron kernel
%	structure into a vector of parameters for optimisation.
%	 Returns:
%	  PARAM - vector of parameters extracted from the kernel. If the
%	   field 'transforms' is not empty in the kernel matrix, the
%	   parameters will be transformed before optimisation (for example
%	   positive only parameters could be logged before being returned).
%	 Arguments:
%	  KERN - the kernel structure containing the parameters to be
%	   extracted.
%	DESC Extract parameters and parameter names from the automatic relevance
%	determination multi-layer perceptron kernel structure.
%	ARG kern : the kernel structure containing the parameters to be
%	extracted.
%	RETURN param : vector of parameters extracted from the kernel. If
%	the field 'transforms' is not empty in the kernel matrix, the
%	parameters will be transformed before optimisation (for example
%	positive only parameters could be logged before being returned).
%	RETURN names : cell array of strings containing parameter names.
%	
%	
%	
%
%	See also
%	% SEEALSO MLPARDKERNPARAMINIT, MLPARDKERNEXPANDPARAM, KERNEXTRACTPARAM, SCG, CONJGRAD


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	mlpardKernExtractParam.m CVS version 1.5
% 	mlpardKernExtractParam.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z

params = [kern.weightVariance kern.biasVariance kern.variance kern.inputScales];

if nargout > 1
  names = {'weight variance', 'bias variance', 'variance'};
  for i = 1:length(kern.inputScales)
    names{3+i} = ['input scale ' num2str(i)];
  end
end