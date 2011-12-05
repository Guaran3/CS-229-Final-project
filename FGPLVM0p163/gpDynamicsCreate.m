function model = gpDynamicsCreate(q, d, latentVals, options, varargin)

% GPDYNAMICSCREATE Create the dynamics model.
%
%	Description:
%
%	MODEL = GPDYNAMICSCREATE(Q, Q, X, OPTIONS, DIFF, LEARN, SEQ) creates
%	a Gaussian process model for dealing with dynamics in the latent
%	space of a GP-LVM.
%	 Returns:
%	  MODEL - model structure containing the Gaussian process.
%	 Arguments:
%	  Q - the latent space dimension.
%	  Q - the latent space dimension.
%	  X - the latent variables.
%	  OPTIONS - options structure as defined by gpOptions.m.
%	  DIFF - Whether or not to use differences between points in the
%	   latent space as the targets for the GP or absolute location of
%	   points (default 1).
%	  LEARN - Whether or not to learn the parameters of the dynamics
%	   model (default 0).
%	  SEQ - array containing the indices of the last frame of each
%	   sequence in the data. The array should be the same length as the
%	   number of sequences in the data (default N, where N is total
%	   number of frames in the model). the latent space as the inputs to
%	   the GP or absolute location of points.
%	
%
%	See also
%	GPCREATE, GPDYNAMICSLATENTGRADIENTS, GPDYNAMICSSETLATENTVALUES, GPDYNAMICSLOGLIKELIHOOD


%	Copyright (c) 2005, 2006 Neil D. Lawrence and Carl Henrik Ek
% 	gpDynamicsCreate.m CVS version 1.5
% 	gpDynamicsCreate.m SVN version 29
% 	last update 2007-11-03T14:33:44.000000Z

if nargin>4
  diff = varargin{1};
else 
  diff = 1;
end
if nargin > 5
  learn = varargin{2};
else
  learn = 0;
end
if nargin > 6
  seq = varargin{3};
else
  seq = size(latentVals, 1);
end
  
if(iscell(options))
  varargin = options;
  options = varargin{1};
  diff = varargin{2};
  learn = varargin{3};
  seq = varargin{4};
end

% set source and target
X = [];y = [];
startVal = 1;
for i = 1:length(seq)
  endVal = seq(i);
  X = [X; latentVals(startVal:endVal-1, :)];
  y = [y; latentVals(startVal+1:endVal, :)];
  startVal = endVal + 1;
end

if diff
  y = y - X;
end
model = gpCreate(q, d, X, y, options);

model.diff = diff;
model.learn = learn;
model.type = 'gpDynamics';
model.seq = seq;
model.dynamicsType = 'auto-regressive';