function model = isomapReconstruct(isomapInfo, y)

% ISOMAPRECONSTRUCT Reconstruct an isomap form component parts.
%
%	Description:
%
%	MODEL = ISOMAPRECONSTRUCT(ISOMAPINFO, Y) takes component parts of an
%	isomap model and reconstructs the isomap model. The component parts
%	are normally retrieved from a saved file.
%	 Returns:
%	  MODEL - an isomap model structure that combines the component
%	   parts.
%	 Arguments:
%	  ISOMAPINFO - the active set and other information stored in a
%	   structure.
%	  Y - the output target training data for the isomap.
%	
%
%	See also
%	ISOMAPDECONSTRUCT, ISOMAPCREATE


%	Copyright (c) 2009 Neil D. Lawrence
% 	isomapReconstruct.m SVN version 545
% 	last update 2009-10-08T13:16:52.000000Z

  model = isomapInfo;
  model.Y = y;
    
end
