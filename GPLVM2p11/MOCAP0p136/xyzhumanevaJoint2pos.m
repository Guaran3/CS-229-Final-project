function pos = xyzhumanevaJoint2pos(joint)

% XYZHUMANEVAJOINT2POS
%
%	Description:
%	


%	Copyright (c) 2008 Carl Henrik Ek and Neil Lawrence
% 	xyzhumanevaJoint2pos.m SVN version 119
% 	last update 2008-10-21T09:52:55.000000Z


pos = zeros(1,prod(size(joint)));

pos(1:3:end) = joint(:,1);
pos(2:3:end) = joint(:,2);
pos(3:3:end) = joint(:,3);

return