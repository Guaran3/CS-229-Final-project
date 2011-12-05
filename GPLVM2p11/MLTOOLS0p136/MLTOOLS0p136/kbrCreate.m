function model = kbrCreate(inputDim, outputDim, options)

% KBRCREATE Create a KBR model.
%
%	Description:
%	The kernel based regression model is simply a model for least
%	squares regression in a kernel feature space. Any kernel from the KERN
%	toolbox can be specified. The model was developed for providing kernel
%	based back constraints in the GP-LVM. Please consider using a Gaussian
%	process model (through the GP toolbox) if you are interested in the
%	model for regression.
%	
%
%	MODEL = KBRCREATE(OPTIONS) creates a kernel based regression model
%	structure given an options structure.
%	 Returns:
%	  MODEL - the model structure with the default parameters placed in.
%	 Arguments:
%	  OPTIONS - an options structure that determines the form of the
%	   model.
%	
%
%	See also
%	KBROPTIONS, KBRPARAMINIT, MODELCREATE


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	kbrCreate.m CVS version 1.3
% 	kbrCreate.m SVN version 24
% 	last update 2007-01-05T07:24:49.000000Z


model.type = 'kbr';
model.inputDim = inputDim;
model.outputDim = outputDim;
model.numData = size(options.X, 1);
model.numParams = (model.numData + 1)*outputDim;
model.X = options.X;
if isstruct(options.kern)
  model.kern = options.kern;
else
  model.kern = kernCreate(options.X, options.kern);
end

model.K = kernCompute(model.kern, options.X);
model = kbrParamInit(model);
