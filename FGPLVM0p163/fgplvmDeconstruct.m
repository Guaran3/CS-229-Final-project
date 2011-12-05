function [kern, noise, fgplvmInfo, X] = fgplvmDeconstruct(model)

% FGPLVMDECONSTRUCT break FGPLVM in pieces for saving.
%
%	Description:
%
%	[KERN, NOISE, FGPLVMINFO] = FGPLVMDECONSTRUCT(MODEL) takes an FGPLVM
%	model structure and breaks it into component parts for saving.
%	 Returns:
%	  KERN - the kernel component of the FGPLVM model.
%	  NOISE - the noise component of the FGPLVM model.
%	  FGPLVMINFO - a structure containing the other information from the
%	   FGPLVM: what the active set is, what the inactive set is and what
%	   the site parameters are.
%	 Arguments:
%	  MODEL - the model that needs to be saved.
%	
%
%	See also
%	FGPLVMRECONSTRUCT, GPDECONSTRUCT


%	Copyright (c) 2009 Neil D. Lawrence
% 	fgplvmDeconstruct.m SVN version 545
% 	last update 2009-10-07T13:42:52.000000Z

  [kern, noise, fgplvmInfo] = gpDeconstruct(model);
  if isfield(fgplvmInfo, 'back') && ~isempty(fgplvmInfo.back)
    switch fgplvmInfo.back.type
     case 'kbr'
      backToRemove = {'K', 'X'};
      
     otherwise
      backToRemove = {};
    end
    
    for i = 1:length(backToRemove)
      if isfield(fgplvmInfo.back, backToRemove{i})
        fgplvmInfo.back = rmfield(fgplvmInfo.back, backToRemove{i});
      end
    end
  end
  if isfield(fgplvmInfo, 'dynamics') && ~isempty(fgplvmInfo.dynamics)
    switch fgplvmInfo.dynamics.type 
     case 'gp'
      dynamicsToRemove = {};
     case 'gpDynamics'
      dynamicsToRemove = {'X', 'y', 'm', 'K_uu', 'K_uf', 'invK_uu', 'sqrtK_uu', 'logDetK_uu', ...
                          'diagK', 'L', 'diagD', 'Dinv', 'A', 'Ainv', 'logDetA', 'detDiff', ...
                          'innerProducts', 'V', 'Am', 'Lm', 'invLmV', ...
                          'scaledM', 'bet', 'K', 'D', 'logDetD'};
      
     otherwise
      dynamicsToRemove ={};
    end
    for i = 1:length(dynamicsToRemove)
      if isfield(fgplvmInfo.dynamics, dynamicsToRemove{i})
        fgplvmInfo.dynamics = rmfield(fgplvmInfo.dynamics, dynamicsToRemove{i});
      end
    end
  end
  X = model.X;
  fgplvmInfo.type = 'fgplvm';
end
