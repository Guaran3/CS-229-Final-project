function g = gplvmApproxLogLikeActiveSetGrad(model)

% GPLVMAPPROXLOGLIKEACTIVESETGRAD Gradient of the approximate likelihood wrt active set.
%
%	Description:
%	g = gplvmApproxLogLikeActiveSetGrad(model)
%% 	gplvmApproxLogLikeActiveSetGrad.m CVS version 1.5
% 	gplvmApproxLogLikeActiveSetGrad.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

x = model.X(model.I, :);
m = model.m(model.I, :);
K = kernCompute(model.kern, x);
g = zeros(1, length(model.I)*size(model.X, 2));

if model.noise.spherical
  % there is only one value for all beta
  invK = pdinv(K+diag(1./model.beta(model.I, 1)));
end

for j = 1:size(m, 2)
  if ~model.noise.spherical
    invK = pdinv(K+diag(1./model.beta(model.I, j)));
  end
  covGrad = feval([model.type 'CovarianceGradient'], invK, m(:, j));
  g = g + activeSetGradient(model, covGrad);
end  

function g = activeSetGradient(model, covGrad)

% ACTIVESETGRADIENT Gradient of the kernel with respect to its active points.


xDim = size(model.X, 2);
g = zeros(length(model.I), xDim);
Xactive = model.X(model.I, :);

gx = kernGradX(model.kern, Xactive, Xactive);
% The 2 accounts for the fact that covGrad is symmetric.
gx = gx*2;
% gx has assumed that n is not in model.I, fix that here.
dgx = kernDiagGradX(model.kern, Xactive);
for i = 1:length(model.I)
  gx(i, :, i) = dgx(i, :);
end

for i = 1:length(model.I)
  n = model.I(i);
  for j = 1:xDim
    g(i, j) = gx(:, j, i)'*covGrad(:, i);
  end
end
g = g(:)';
