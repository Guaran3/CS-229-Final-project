function X = gplvmPcaInit(Y, dims)

% GPLVMPCAINIT Initialise gplvm model with PCA.
%
%	Description:
%	X = gplvmPcaInit(Y, dims)
%% 	gplvmPcaInit.m CVS version 1.7
% 	gplvmPcaInit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

[X, sigma2] = ppcaEmbed(Y, dims);