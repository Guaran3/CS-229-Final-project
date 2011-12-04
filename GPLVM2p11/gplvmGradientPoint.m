function g = gplvmGradientPoint(x_i, i, model, A) %A, invK, activeX, Y, D, theta, activeSet)

% GPLVMGRADIENTPOINT Compute gradient of data-point likelihood wrt x.
%
%	Description:
%	g = gplvmGradientPoint(x_i, i, model, A) %A, invK, activeX, Y, D, theta, activeSet)
%% 	gplvmGradientPoint.m CVS version 1.4
% 	gplvmGradientPoint.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

g = -feval([model.noiseType 'GradientPoint'], x_i, i, model, A);

