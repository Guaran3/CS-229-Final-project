function [params, names] = rbfperiodicExtractParam(model)

% RBFPERIODICEXTRACTPARAM Extract parameters from the RBFPERIODIC model structure.
%
%	Description:
%
%	PARAM = RBFPERIODICEXTRACTPARAM(MODEL) extracts parameters from the
%	periodic radial basis function model structure into a vector of
%	parameters for optimisation.
%	 Returns:
%	  PARAM - vector of parameters extracted from the model.
%	 Arguments:
%	  MODEL - the model structure containing the parameters to be
%	   extracted.
%
%	[PARAM, NAMES] = RBFPERIODICEXTRACTPARAM(MODEL) extracts parameters
%	and parameter names from the periodic radial basis function model
%	structure.
%	 Returns:
%	  PARAM - vector of parameters extracted from the model.
%	  NAMES - cell array of strings containing names for each parameter.
%	 Arguments:
%	  MODEL - the model structure containing the parameters to be
%	   extracted.
%	
%	
%
%	See also
%	% SEEALSO RBFPERIODICCREATE, RBFPERIODICEXPANDPARAM, MODELEXTRACTPARAM, SCG, CONJGRAD


%	Copyright (c) 2007 Neil D. Lawrence
% 	rbfperiodicExtractParam.m CVS version 1.1
% 	rbfperiodicExtractParam.m SVN version 24
% 	last update 2007-02-02T23:13:23.000000Z
fhandle = str2func([model.widthTransform.type 'Transform']);
params = [model.thetaBar(:)' ...
          fhandle(model.sigma2(:)', 'xtoa') ...
          model.weights(:)'  ...
          model.bias(:)'];
if nargout > 1
  counter = 0;
  for j = 1:size(model.thetaBar, 2)
    for i = 1:size(model.thetaBar, 1)
      counter = counter + 1;
      names{counter} = ['Center position ' num2str(i) '-' num2str(j)];
    end
  end
  for j = 1:size(model.sigma2, 2)
    counter = counter + 1;
    names{counter} = ['Basis function width ' num2str(j)];
  end
  for j = 1:size(model.weights, 2)
    for i = 1:size(model.weights, 1)
      counter = counter + 1;
      names{counter} = ['Output weight ' num2str(i) '-' num2str(j)];
    end
  end
  for j = 1:size(model.bias, 2)
    counter = counter + 1;
    names{counter} = ['Output node bias ' num2str(j)];
  end
end