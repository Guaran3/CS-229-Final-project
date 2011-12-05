function xyz = skel2xyz(skel, channels)

% SKEL2XYZ Compute XYZ values given skeleton structure and channels.
%
%	Description:
%
%	XYZ = SKEL2XYZ(SKEL, CHANNELS) Computes X, Y, Z coordinates given a
%	BVH or acclaim skeleton structure and an associated set of channels.
%	 Returns:
%	  XYZ - the point cloud positions for the skeleton.
%	 Arguments:
%	  SKEL - a skeleton for the bvh file.
%	  CHANNELS - the channels for the bvh file.
%	
%
%	See also
%	ACCLAIM2XYZ, BVH2XYZ


%	Copyright (c) 2006 Neil D. Lawrence
% 	skel2xyz.m CVS version 1.2
% 	skel2xyz.m SVN version 42
% 	last update 2008-08-12T20:23:47.000000Z

fname = str2func([skel.type '2xyz']);
xyz = fname(skel, channels);