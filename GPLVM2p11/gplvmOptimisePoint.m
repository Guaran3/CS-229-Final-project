function model = gplvmOptimisePoint(model, i, prior, display, iters);

% GPLVMOPTIMISEPOINT Optimise the postion of a non-active point.
%
%	Description:
%	model = gplvmOptimisePoint(model, i, prior, display, iters);
%% 	gplvmOptimisePoint.m CVS version 1.5
% 	gplvmOptimisePoint.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

if nargin < 5
  iters = 500;
  if nargin < 4
    display = 1;
    if nargin < 3
      prior = [];
    end
  end
end


options = optOptions;
if display
  options(1) = 1;
  options(9) = 1;
end
options(14) = iters;


model.X(i, :) = scg('pointNegLogLikelihood', model.X(i, :),  options, ...
		    'pointNegGradX', model.y(i, :), model, prior);

