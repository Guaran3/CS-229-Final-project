function connection = bvhConnectionMatrix(skel);

% BVHCONNECTIONMATRIX Compute the connection matrix for the structure.
%
%	Description:
%
%	CONNECTION = BVHCONNECTIONMATRIX(SKEL) computes the connection
%	matrix for the structure. Returns a matrix which has zeros at all
%	entries except those that are connected in the skeleton.
%	 Returns:
%	  CONNECTION - connectivity matrix.
%	 Arguments:
%	  SKEL - the skeleton for which the connectivity is required.
%	
%
%	See also
%	SKELCONNECTIONMATRIX


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	bvhConnectionMatrix.m CVS version 1.3
% 	bvhConnectionMatrix.m SVN version 42
% 	last update 2008-08-12T20:23:47.000000Z

connection = skelConnectionMatrix(skel);

