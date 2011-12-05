function gX = gpTimeDynamicsLatentGradients(model);

% GPTIMEDYNAMICSLATENTGRADIENTS Gradients of the X vector given the time dynamics model.
%
%	Description:
%
%	GX = GPTIMEDYNAMICSLATENTGRADIENTS(MODEL) Compute the gradients of
%	the log likelihood of a Gaussian proces time dynamics model with
%	respect to the latent points in the GP-LVM model.
%	 Returns:
%	  GX - the gradients with respec to latent points.
%	 Arguments:
%	  MODEL - the GP model for which log likelihood is to be computed.
%	
%
%	See also
%	GPTIMEDYNAMICSCREATE, GPTIMEDYNAMICSLOGLIKELIHOOD


%	Copyright (c) 2006, 2009 Neil D. Lawrence
% 	gpTimeDynamicsLatentGradients.m CVS version 1.2
% 	gpTimeDynamicsLatentGradients.m SVN version 178
% 	last update 2009-01-08T13:58:34.000000Z

  
% The first point in each sequence cannot have dynamics thus the +
% length(model.seq)
gX = zeros(model.N+length(model.seq), model.d);
  

% Compute the indices of the input and outputs to the dynamics.
ind_in = [];
ind_out = []; 
startVal=1;
for i = 1:length(model.seq)
  endVal = model.seq(i);
  ind_in = [ind_in startVal:endVal-1];
  ind_out = [ind_out startVal+1:endVal];
  startVal = endVal + 1;
end


% Deal with the fact that X appears in the *target* for the dynamics.
switch model.approx
 case 'ftc'
  for i =1:model.d
    gX(ind_out, i) = gX(ind_out, i) - 1/model.scale(i)*model.invK_uu*model.m(:, i);
    if model.diff
      gX(ind_in, i) = gX(ind_in, i) + 1/model.scale(i)*model.invK_uu*model.m(:, i);
    end
  end
 
 case {'dtc', 'dtcvar'}
  % Deterministic training conditional.
  AinvK_uf = pdinv((1/model.beta)*model.K_uu  ...
                   + model.K_uf*model.K_uf') ...
      *model.K_uf;
  for i = 1:model.d 
    gX(ind_out, i) = gX(ind_out, i) ...
        - 1/model.scale(i)*model.beta*model.m(:, i) ...
        + 1/model.scale(i)*model.beta*model.K_uf' ...
        *(AinvK_uf*model.m(:, i));
    if model.diff
      gX(ind_in, i) = gX(ind_in, i) ...
          + 1/model.scale(i)*model.beta*model.m(:, i) ...
          - 1/model.scale(i)*model.beta*model.K_uf' ...
          *(AinvK_uf*model.m(:, i));
    end
  end
  
 case 'fitc'
  % Fully independent training conditional.
  K_ufDinv = model.K_uf*model.Dinv;;
  AinvK_ufDinv = model.Ainv*K_ufDinv;
  
  for i = 1:model.d
    gX(ind_out, i) = gX(ind_out, i) ...
        -model.beta/model.scale(i)*sparseDiag(1./model.diagD)*model.m(:, i) ...
        +model.beta/model.scale(i)*K_ufDinv'*AinvK_ufDinv*model.m(:, i);
    if model.diff
      gX(ind_in, i) = gX(ind_in, i) ...
          + model.beta/model.scale(i)*sparseDiag(1./model.diagD)*model.m(:, i) ...
          - model.beta/model.scale(i)*K_ufDinv'*AinvK_ufDinv*model.m(:, i);
    end
  end
  
 case 'pitc'
  % Partially independent training conditional.
  startVal = 1;
  for i = 1:length(model.blockEnd)
    endVal = model.blockEnd(i);
    ind = startVal:endVal;
    gXbase(:, ind) =  model.K_uf(:, ind)*model.Dinv{i};
    startVal = endVal + 1;
  end  
  startVal = 1;
  i = 1;
  while i <= length(model.blockEnd)
    endVal = model.blockEnd(i);
    ind = startVal:endVal;
    K_ufDinv = model.K_uf(:, ind)*model.Dinv{i};
    AinvK_ufDinv = model.Ainv*K_ufDinv;
    for j = 1:model.d      
      gX(ind_out(ind), j) = gX(ind_out(ind), j) - model.beta/model.scale(j)*model.Dinv{i}*model.m(ind, j);
      if model.diff
        gX(ind_in(ind), j) = gX(ind_in(ind), j) - model.beta/model.scale(j)*model.Dinv{i}*model.m(ind, j); 
      end
      gX(ind_out, j) = gX(ind_out, j) + model.beta/model.scale(j)*gXbase'*AinvK_ufDinv*model.m(ind, j);
      if model.diff
        gX(ind_in, j) = gX(ind_in, j) - model.beta/model.scale(j)*gXbase'*AinvK_ufDinv*model.m(ind, ...
                                                          j);
      end
      
    end
    startVal = endVal + 1;
    i = i + 1;
  end
end % ends approximation cases

% Perhaps think about dealing with first latent point in each
% sequence with a prior.