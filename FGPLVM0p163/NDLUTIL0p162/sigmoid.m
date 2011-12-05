function y = sigmoid(x)

% SIGMOID The sigmoid function
%
%	Description:
%	y = sigmoid(x)
%% 	sigmoid.m CVS version 1.1
% 	sigmoid.m SVN version 22
% 	last update 2006-11-27T21:48:55.000000Z

y = ones(size(x))./(1+exp(-x));