function handle = vector3Visualise(vals)

% VECTOR3VISUALISE  Helper code for plotting a 3-D vector during 2-D visualisation.
%
%	Description:
%	handle = vector3Visualise(vals)
%% 	vector3Visualise.m CVS version 1.4
% 	vector3Visualise.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

handle = plot3(vals(:, 1), vals(:, 2), vals(:, 3), 'rx');
