function X = gplvmKpcaInit(Y, kern, dims)

% GPLVMKPCAINIT Initialise gplvm model with Kernel PCA.
%
%	Description:
%	X = gplvmKpcaInit(Y, kern, dims)
%% 	gplvmKpcaInit.m CVS version 1.5
% 	gplvmKpcaInit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

X = kpcaEmbed(Y, dims, kern);
