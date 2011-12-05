function X = lleEmbed(Y, dims, neighbours)

% LLEEMBED Embed data set with LLE.
%
%	Description:
%	X = lleEmbed(Y, dims, neighbours)
%% 	lleEmbed.m CVS version 1.2
% 	lleEmbed.m SVN version 290
% 	last update 2009-03-08T08:54:36.000000Z

% Wrapper for Sam Roweis' LLE code.

% Note LLE code uses the transpose of a design matrix.
if nargin < 3
  neighbours = 7;
end
if any(any(isnan(Y)))
  error('Cannot initialise gplvm using LLE when missing data is present.')
else
  X = lle(Y', neighbours, dims);
  X = X';
  % Rescale X so that variance is 1 and mean is zero.
  meanX = mean(X);
  X = X-ones(size(Y, 1), 1)*meanX;
  varX = var(X);
  X = X*diag(sqrt(1./varX));
end
