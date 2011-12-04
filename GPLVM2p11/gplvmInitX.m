function [X, var] = gplvmInitX(Y, dims, options)

% GPLVMINITX Initialise the X values.
%
%	Description:
%	[X, var] = gplvmInitX(Y, dims, options)
%% 	gplvmInitX.m CVS version 1.2
% 	gplvmInitX.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

initFunc = options.initX;
initFunc(1) = upper(initFunc(1));

[X, var] = feval(['gplvm' initFunc 'Init'], Y, dims);