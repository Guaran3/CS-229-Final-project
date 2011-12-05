function model = lfmExpandParam(model, params)

% LFMEXPANDPARAM Expand the given parameters into a LFM structure.
%
%	Description:
%
%	MODEL = LFMEXPANDPARAM(MODEL, PARAMS) takes the given vector of
%	parameters and places them in the model structure, it then updates
%	any stored representations that are dependent on those parameters,
%	for example kernel matrices etc..
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
%	LFMCREATE, LFMEXTRACTPARAM, MODELEXTRACTPARAM, LFMUPDATEKERNELS


%	Copyright (c) 2007 Neil D. Lawrence
% 	lfmExpandParam.m SVN version 20
% 	last update 2008-06-06T22:07:01.000000Z

params = real(params);
if isfield(model, 'fix')
  for i = 1:length(model.fix)
    params(model.fix(i).index) = model.fix(i).value;
  end
end

if length(params) ~= model.numParams
  error('Parameter vector is incorrect length');
end
startVal = 1;
endVal = model.kern.nParams;
model.kern = kernExpandParam(model.kern, params(startVal:endVal));

% The mass, springs and dampers  are actually stored in the kernel.
% We'll put them here as well for convenience.
for i = 1:model.kern.numBlocks
  model.mass(i) = model.kern.comp{i}.mass;
  model.spring(i) = model.kern.comp{i}.spring;
  model.damper(i) = model.kern.comp{i}.damper;
  model.sensitivity(i) = model.kern.comp{i}.sensitivity;
end

model = lfmUpdateKernels(model);
lengthObs = size(model.t, 1);
ind = 1:lengthObs;
for i = 1:model.numDisplacements
  if isfield(model, 'mu')
    model.m(ind) = model.y(ind) - model.mu(i)*ones(lengthObs, 1);
  else
    model.m(ind) = model.y(ind);
  end
  ind = ind + lengthObs;
end
