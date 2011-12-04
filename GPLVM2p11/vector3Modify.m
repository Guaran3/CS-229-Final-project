function vector3Modify(handle, values)

% VECTOR3MODIFY Helper code for visualisation of 3-D vectorial data.
%
%	Description:
%	vector3Modify(handle, values)
%% 	vector3Modify.m CVS version 1.4
% 	vector3Modify.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

set(handle, 'XData', values(1));
set(handle, 'YData', values(2));
set(handle, 'ZData', values(3));

disp(values)