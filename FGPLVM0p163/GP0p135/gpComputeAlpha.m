function model = gpComputeAlpha(model, m)

% GPCOMPUTEALPHA Update the vector `alpha' for computing posterior mean quickly.
%
%	Description:
%
%	MODEL = GPCOMPUTEALPHA(MODEL, M) updates the vectors that are known
%	as `alpha' in the support vector machine, in other words invK*y,
%	where y is the target values.
%	 Returns:
%	  MODEL - the model with the updated alphas.
%	 Arguments:
%	  MODEL - the model for which the alphas are going to be updated.
%	  M - the values of m for which the updates will be made.
%	
%
%	See also
%	GPCREATE, GPUPDATEAD, GPUPDATEKERNELS


%	Copyright (c) 2006, 2009 Neil D. Lawrence
% 	gpComputeAlpha.m CVS version 1.1
% 	gpComputeAlpha.m SVN version 178
% 	last update 2009-01-08T13:46:22.000000Z

if nargin < 2
  m = model.m;
end

switch model.approx
 case 'ftc'
  model.alpha = zeros(model.N, model.d);
  if ~isfield(model, 'isSpherical') | model.isSpherical
    model.alpha = model.invK_uu*m;
  else
    for i = 1:model.d
      ind = gpDataIndices(model, i);
      model.alpha(ind, i) = model.invK_uu{i}* ...
          m(ind, i);
    end
  end
 
 case {'dtc', 'dtcvar'}
  model.alpha = zeros(model.k, model.d);
  if ~isfield(model, 'isSpherical') | model.isSpherical
    model.alpha = model.Ainv*model.K_uf*m;
  else
    for i = 1:model.d
      ind = gpDataIndices(model, i);
      model.alpha(:, i) = model.Ainv{i} ...
          *model.K_uf(:, ind) ...
          *m(ind, i);
    end
  end
 case 'fitc'
  model.alpha = zeros(model.k, model.d);
  if ~isfield(model, 'isSpherical') | model.isSpherical
    model.alpha = model.Ainv*model.K_uf*model.Dinv*m;
  else
    for i = 1:model.d
      ind = gpDataIndices(model, i);
      model.alpha(:, i) = model.Ainv{i} ...
          *model.K_uf(:, ind) ...
          *model.Dinv{i}*m(ind, i);
    end
  end
 case 'pitc'
  model.alpha = zeros(model.k, model.d);
  if ~isfield(model, 'isSpherical') | model.isSpherical
    for i = 1:length(model.blockEnd)
      ind = gpBlockIndices(model, i);
      model.alpha = model.alpha+model.Ainv*model.K_uf(:, ind)* ...
          model.Dinv{i}*m(ind, :);
    end
  else
    for i = 1:length(model.blockEnd)
      for j = 1:model.d
        ind = gpDataIndices(model, j, i);
        model.alpha(:, j) = model.alpha(:, j)+model.Ainv{j}*model.K_uf(:, ind)* ...
            model.Dinv{i, j}*m(ind, j);
      end
    end  
  end
end