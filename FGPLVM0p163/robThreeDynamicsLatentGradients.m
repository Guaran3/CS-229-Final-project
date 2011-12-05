function gX = robThreeDynamicsLatentGradients(model);

% ROBTHREEDYNAMICSLATENTGRADIENTS Gradients of the X vector given the dynamics model.
%
%	Description:
%	gX = robThreeDynamicsLatentGradients(model);
%% 	robThreeDynamicsLatentGradients.m CVS version 1.2
% 	robThreeDynamicsLatentGradients.m SVN version 29
% 	last update 2007-11-03T14:33:27.000000Z

gX = zeros(size(model.X));

for i = 1:size(model.diffX)-1
  covMat = model.lambda*model.diffX(i, :)'*model.diffX(i, :) + ...
           eye(2)*model.sigma2;
  invCov = inv(covMat);

  gX(i, :) = gX(i, :) + 2*model.diffX(i, :)*invCov*model.diffX(i+1, :)'*model.diffX(i+1, :)*invCov;
      ;
  gX(i+1, :) = gX(i+1, :) - 2*model.diffX(i, :)*invCov*model.diffX(i+1, :)'*model.diffX(i+1, :)*invCov;
  gX(i+1, :) = gX(i+1, :) - 2*model.diffX(i+1, :)*invCov; 
  gX(i+2, :) = gX(i+2, :) + 2*model.diffX(i+1, :)*invCov; 
end
gX = gX*-.5;