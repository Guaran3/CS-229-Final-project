function model = linearExpandParam(model, params, dim);

% LINEAREXPANDPARAM Update linear model with vector of parameters.
%
%	Description:
%	
%	


%	With modifications by Carl Henrik Ek 2009
% 	linearExpandParam.m CVS version 1.2
% 	linearExpandParam.m SVN version 760
% 	last update 2010-04-13T16:04:31.000000Z
if(nargin<3)
  startVal = 1;
  endVal = model.inputDim*model.outputDim;
  model.W = reshape(params(1:endVal), model.inputDim, model.outputDim);
  model.b = params(endVal+1:end);
else
  model.W(:,dim) = params(1:1:model.inputDim*length(dim));
  model.b(:,dim) = params(model.inputDim*length(dim)+1:1:end);
end