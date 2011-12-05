function Y = modelSamp(model, X)

% MODELSAMP Give a sample from a model for given X.
%
%	Description:
%	Y = modelSamp(model, X)
%% 	modelSamp.m CVS version 1.1
% 	modelSamp.m SVN version 24
% 	last update 2006-01-17T10:46:29.000000Z

fhandle = str2func([model.type 'Samp']);
Y = fhandle(model, X);