function X = smallrandEmbed(Y, dims)

% SMALLRANDEMBED Embed data set with small random values.
%
%	Description:
%
%	X = SMALLRANDEMBED(Y, DIMS) returns (initial) latent positions for a
%	given data set.
%	 Returns:
%	  X - the latent positions.
%	 Arguments:
%	  Y - the data set which you want the latent positions for.
%	  DIMS - the dimensionality of the latent space.
%	
%
%	See also
%	LLEEMBED, ISOMAPEMBED, PPCAEMBED


%	Copyright (c) 2006 Neil D. Lawrence
% 	smallrandEmbed.m CVS version 1.1
% 	smallrandEmbed.m SVN version 24
% 	last update 2006-07-27T18:58:42.000000Z

X = randn(size(Y, 1), dims)*0.0001;
