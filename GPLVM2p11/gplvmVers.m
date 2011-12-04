function [vers, depend] = gplvmVers

% GPLVMVERS Brings dependent toolboxes into the path.
%
%	Description:
%	[vers, depend] = gplvmVers
%% 	gplvmVers.m CVS version 1.2
% 	gplvmVers.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

vers = 2.02;
if nargout > 2
  depend(1).name = 'ivm';
  depend(1).vers = 0.32;
  depend(1).required = 0;
end