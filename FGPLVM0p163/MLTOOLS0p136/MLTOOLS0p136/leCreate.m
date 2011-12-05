function model = leCreate(inputDim, outputDim, Y, options)

% LECREATE Laplacian eigenmap model.
%
%	Description:
%
%	MODEL = LECREATE(LATENTDIMENSION, OUTPUTDIM, Y, OPTIONS) creates a
%	structure for a Laplacian eigenmap model.
%	 Returns:
%	  MODEL - model structure containing LE model.
%	 Arguments:
%	  LATENTDIMENSION - dimension of latent space.
%	  OUTPUTDIM - dimension of data.
%	  Y - the data to be modelled in design matrix format (as many rows
%	   as there are data points).
%	  OPTIONS - options structure as returned by leOptions.
%	
%
%	See also
%	LEOPTIONS, MODELCREATE


%	Copyright (c) 2009 Neil D. Lawrence
% 	leCreate.m SVN version 509
% 	last update 2009-10-08T14:01:32.000000Z


model.type = 'le';

if size(Y, 2) ~= outputDim
  error(['Input matrix Y does not have dimension ' num2str(d)]);
end
model.isNormalised = options.isNormalised;
model.weightType = options.weightType;
model.weightScale = options.weightScale;
model.regulariser = options.regulariser;
model.k = options.numNeighbours;
model.Y = Y;
model.d = outputDim;
model.q = inputDim;
model.N = size(Y, 1);
