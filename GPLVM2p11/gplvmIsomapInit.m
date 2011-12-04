function [X, sigma2] = gplvmIsomapInit(Y, dims)

% GPLVMISOMAPINIT Initialise gplvm model with isomap (need isomap toolbox).
%
%	Description:
%	[X, sigma2] = gplvmIsomapInit(Y, dims)
%% 	gplvmIsomapInit.m CVS version 1.3
% 	gplvmIsomapInit.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

[X, sigma2] = isomapEmbed(Y, dims);