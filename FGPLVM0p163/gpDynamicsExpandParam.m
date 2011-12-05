function model = gpDynamicsExpandParam(model, params)

% GPDYNAMICSEXPANDPARAM Place the parameters vector into the model for GP dynamics.
%
%	Description:
%
%	MODEL = GPDYNAMICSEXPANDPARAM(MODEL, PARAMS) takes the given vector
%	of parameters and places them in the model structure, it then
%	updates any stored representations that are dependent on those
%	parameters, for example kernel matrices etc..
%	 Returns:
%	  MODEL - a returned model structure containing the updated
%	   parameters.
%	 Arguments:
%	  MODEL - the model structure for which parameters are to be
%	   updated.
%	  PARAMS - a vector of parameters for placing in the model
%	   structure.
%	
%
%	See also
%	GPEXPANDPARAM, GPDYNAMICSCREATE, GPDYNAMICSEXTRACTPARAM, MODELEXTRACTPARAM, GPUPDATEKERNELS


%	Copyright (c) 2006, 2009 Neil D. Lawrence
% 	gpDynamicsExpandParam.m CVS version 1.5
% 	gpDynamicsExpandParam.m SVN version 178
% 	last update 2009-01-08T13:53:30.000000Z


% get the current parameter vector
origParam = gpExtractParam(model);

% Get X_u
if ~isfield(model, 'fixInducing') | ~model.fixInducing
  % Substitute for X_u.
  paramsEnd = model.k*model.q;
  paramsStart = 1;
  origParam(paramsStart:paramsEnd) = params(paramsStart:paramsEnd);
else
  % X_u values are taken from X values.
  model.X_u = model.X(model.inducingIndices, :);
  paramsEnd = 0;
end

% Subsitute for any parameters to be optimised.
if model.learn
  origParam(paramsEnd+1:end) = params(paramsEnd+1:end);
elseif model.learnScales
  switch model.approx
    % This relies on scale parameters being at end of vector.
   case 'ftc'
    endVal = length(origParam);
    startVal = endVal-model.d+1;
   case {'dtc', 'dtcvar', 'fitc', 'pitc'}
    endVal = length(origParam)-1;
    startVal = endVal-model.d+1;
  end
  origParam(startVal:endVal) = params(paramsEnd+1:end);    
end

% Now use the standard gpExpandParam
model = gpExpandParam(model, origParam);