function g = dnetLogLikeGradients(model)

% DNETLOGLIKEGRADIENTS Density network gradients.
%
%	Description:
%
%	G = DNETLOGLIKEGRADIENTS(MODEL) computes the gradients of the log
%	likelihood of a density network with respect to the parameters.
%	 Returns:
%	  G - the gradients of the model log likelihood.
%	 Arguments:
%	  MODEL - the model structure for computing the log likelihood.
%	
%
%	See also
%	MODELLOGLIKEIHOOD, DNETLOGLIKELIHOOD


%	Copyright (c) 2008 Neil D. Lawrence
% 	dnetLogLikeGradients.m SVN version 24
% 	last update 2008-06-16T15:05:46.000000Z

diffVal = zeros(model.N, model.M);
Ypred = dnetOut(model, model.X_u);
if ~model.basisStored
  model = dnetEstep(model, Ypred);
end
gMapping = zeros(1, model.mapping.numParams);
gOut = modelOutputGrad(model.mapping, model.X_u);
if model.N > model.M
  for k = 1:model.M
    diffY = model.beta*(model.y - repmat(Ypred(k, :), model.N, 1));
    for j = 1:model.d
      gMapping = gMapping + full(gOut(k, :, j)*(diffY(:, j)'*model.w(:, k)));
    end
  end
else
  for i = 1:model.N
    diffY = model.beta*(repmat(model.y(i, :), model.M, 1) - Ypred);
    for j = 1:model.d
      gMapping = gMapping + full(sum(gOut(:, :, j).*repmat(diffY(:, j).*model.w(i, :)', 1, ...
                                         model.mapping.numParams), 1));
    end
  end
end

tot = 0;
if model.N > model.M
  for i = 1:model.M
    diffY = model.y - repmat(Ypred(i, :), model.N, 1);
    diffY =diffY.*diffY.*repmat(model.w(:,i), 1, model.d);
    tot = tot + sum(sum(diffY));
  end
else
  for i = 1:model.N
    diffY = repmat(model.y(i, :), model.M, 1) - Ypred;
    diffY = diffY.*diffY.*repmat(model.w(i,:)', 1, model.d);
    tot = tot + sum(sum(diffY));
  end
end
gBeta = model.N*model.d/model.beta - tot;
gBeta = gBeta/2;

func = str2func([model.betaTransform 'Transform']);
gBeta = gBeta*func(model.beta, 'gradfact');

g = [gMapping gBeta];