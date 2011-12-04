function [X, kern, noise, ivmInfo] = gplvmDeconstruct(model, fileName)

% GPLVMDECONSTRUCT break GPLVM in pieces for saving.
%
%	Description:
%	[X, kern, noise, ivmInfo] = gplvmDeconstruct(model, fileName)
%% 	gplvmDeconstruct.m CVS version 1.2
% 	gplvmDeconstruct.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

X = model.X;
kern = rmfield(model.kern, 'Kstore');
kern = rmfield(kern, 'diagK');
noise = model.noise;
ivmInfo.I = model.I;
ivmInfo.J = model.J;
ivmInfo.m = model.m;
ivmInfo.beta = model.beta;

