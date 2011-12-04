function [model, lbls] = gplvmLoadResult(dataSet, number)

% GPLVMLOADRESULT Load a previously saved result.
%
%	Description:
%	[model, lbls] = gplvmLoadResult(dataSet, number)
%% 	gplvmLoadResult.m CVS version 1.3
% 	gplvmLoadResult.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

[Y, lbls] = lvmLoadData(dataSet);

dataSet(1) = upper(dataSet(1));
load(['dem' dataSet num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);
