function model = mogUpdateCovariance(model)

% MOGUPDATECOVARIANCE Update the covariances of an MOG model.
%
%	Description:
%
%	MODEL = MOGUPDATECOVARIANCE(MODEL) updates the covariance matrices
%	of a mixtures of Gaussians model. The implementation currently uses
%	an eigenvalue based update.
%	 Returns:
%	  MODEL - the model with updated covariances.
%	 Arguments:
%	  MODEL - the model which is to be updated.
%	
%
%	See also
%	MOGCREATE, MOGUPDATEMEAN, MOGESTEP


%	Copyright (c) 2006 Neil D. Lawrence
% 	mogUpdateCovariance.m CVS version 1.2
% 	mogUpdateCovariance.m SVN version 24
% 	last update 2008-01-02T23:53:55.000000Z

for i = 1:model.m

  centredY = model.Y - repmat(model.mean(i,:), model.N, 1);
  centredY = centredY.*repmat(sqrt(model.posterior(:,i)), 1, model.d);
  switch model.covtype
    case 'ppca'
     C = (centredY'*centredY+0.001*eye(model.d))/sum(model.posterior(:, i)+.001);
     [vec, val] = eig(C);
     val = diag(val);
     [val, ind] = sort(val);
     ind = ind(end:-1:1);
     val = val(end:-1:1);
     vec = vec(:, ind(1:model.q));
     sigma2 = mean(val(model.q+1:end));
     if sigma2<eps
       sigma2 = eps;
     end
     lambda = val(1:model.q) - sigma2;
     %[sigma2, eigVec, lambda] = ppca(C, model.q);
     if length(lambda) ~= model.q
       % Something's wrong here ...
       sigma2 = 1e-6;
       warning('Not enough eigenvalues extracted.')
       lambdaTemp = lambda;
       lambda = zeros(model.q, 1);
       lambda(1:length(lambdaTemp)) = lambdaTemp;
     end 
    
     model.sigma2(i) = sigma2;
     model.W{i} = vec*diag(sqrt(lambda));
     model.U{i} = sqrt(sigma2)*eye(model.d);
     for j = 1:model.q
       model.U{i} = cholupdate(model.U{i}, model.W{i}(:, j));
     end
   case 'spherical'
    model.sigma2(i) = sum(sum(centredY.*centredY))/(model.d*sum(model.posterior(:, i)));
  end
end        

