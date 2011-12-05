function model = gpDynamicsSetLatentValues(model, X)

% GPDYNAMICSSETLATENTVALUES Set the latent values inside the model.
%
%	Description:
%
%	MODEL = GPDYNAMICSSETLATENTVALUES(MODEL, X) Distributes GP-LVM
%	latent positions throughout the GP dynamics model.
%	 Returns:
%	  MODEL - the updated model with the relevant latent positions in
%	   place.
%	 Arguments:
%	  MODEL - the model in which the latent positions are to be placed.
%	  X - the latent positions to be placed in the model.
%	
%	
%
%	See also
%	GPDYNAMICSCREATE, GPDYNAMICSLOGLIKELIHOOD


%	Copyright (c) 2006 Neil D. Lawrence and Carl Henrik Ek


%	With modifications by Carl Henrik Ek 2008
% 	gpDynamicsSetLatentValues.m CVS version 1.5
% 	gpDynamicsSetLatentValues.m SVN version 82
% 	last update 2008-09-12T09:31:42.000000Z

ind_in = [];
ind_out = []; 
startVal=1;
for i = 1:length(model.seq)
  endVal = model.seq(i);
  ind_in = [ind_in startVal:endVal-1];
  ind_out = [ind_out startVal+1:endVal];
  startVal = endVal + 1;
end

if(isfield(model,'indexIn')&&~isempty(model.indexIn))
  model.X = X(ind_in,model.indexIn);
else
  model.X = X(ind_in, :);
end
  
if(isfield(model,'indexOut')&&~isempty(model.indexOut))
  if(model.diff)
    model.y = X(ind_out,model.indexOut) - X(ind_in,model.indexOut);
  else
    model.y = X(ind_out,model.indexOut);
  end
else
  if model.diff
    model.y = X(ind_out, :) - X(ind_in, :);
  else
    model.y = X(ind_out, :);
  end
end
model.m = gpComputeM(model);

