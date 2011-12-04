function model = gplvmOptimiseActiveSet(model, prior, display, iters)

% GPLVMOPTIMISEACTIVESET Optimise the location of the active points.
%
%	Description:
%	model = gplvmOptimiseActiveSet(model, prior, display, iters)
%% 	gplvmOptimiseActiveSet.m CVS version 1.5
% 	gplvmOptimiseActiveSet.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

if nargin < 4
  iters = 500;
  if nargin < 3
    display = 1;
    if nargin < 2
      prior = [];
    end
  end
end



xVals = model.X(model.I, :);
xVals = xVals(:)';

options = optOptions;
if display
  options(1) = 1;
  if length(xVals) <= 20
    options(9) = 1;
  end
end
options(14) = iters;

xVals = scg('gplvmActiveSetObjective', xVals,  options, ...
		    'gplvmActiveSetGradient', model, prior);
model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
