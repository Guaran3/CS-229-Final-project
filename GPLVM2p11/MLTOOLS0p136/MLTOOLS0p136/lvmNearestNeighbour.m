function err = lvmNearestNeighbour(model, lbls)

% LVMNEARESTNEIGHBOUR Give the number of errors in latent space for 1 nearest neighbour.
%
%	Description:
%
%	LVMNEARESTNEIGHBOUR(MODEL, LBLS) computes the number errors for 1
%	nearest neighbour in latent space.
%	 Arguments:
%	  MODEL - the model for which the computation is required.
%	  LBLS - the labels of the data.


%	Copyright (c) 2004, 2006, 2008 Neil D. Lawrence
% 	lvmNearestNeighbour.m SVN version 24
% 	last update 2008-06-14T16:48:34.000000Z

d = dist2(model.X, model.X);
for i = 1:size(model.X, 1); 
  d(i, i) = inf; 
end

for i= 1:size(lbls, 1); 
  lbls2(i, :) =  find(lbls(i, :));
end
[void, ind] = min(d);
err = size(model.X, 1) - sum(lbls2(ind) == lbls2);
