function index = skelReverseLookup(skel, jointName)

% SKELREVERSELOOKUP Return the number associated with the joint name.
%
%	Description:
%
%	INDEX = SKELREVERSELOOKUP(SKEL, JOINTNAME) returns the number
%	associated with a particular joint name in a given skeleton.
%	 Returns:
%	  INDEX - the index of the joint name in the skeleton.
%	 Arguments:
%	  SKEL - the skeleton to look up.
%	  JOINTNAME - the joint name to look up.
%	


%	Copyright (c) 2006 Neil D. Lawrence
% 	skelReverseLookup.m CVS version 1.1
% 	skelReverseLookup.m SVN version 42
% 	last update 2008-08-12T20:23:47.000000Z

for i=1:length(skel.tree)
  if strcmp(skel.tree(i).name, jointName)
    index = i;
    return
  end
end

error('Reverse look up of name failed.')
