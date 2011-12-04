function model = gplvmOptimiseKernel(model, prior, display, iters);

% GPLVMOPTIMISEKERNEL Jointly optimise the kernel parameters and active set positions.
%
%	Description:
%	model = gplvmOptimiseKernel(model, prior, display, iters);
%% 	gplvmOptimiseKernel.m CVS version 1.5
% 	gplvmOptimiseKernel.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z


if nargin < 3
  iters = 500;
  if nargin < 2
    display = 1;
  end
end

options = optOptions;
if display
  options(1) = 1;
end
options(14) = iters;


xVals = model.X(model.I, :);
xVals = xVals(:)';

kernParams = kernExtractParam(model.kern);

params = [kernParams xVals];

options = optOptions;
if display
  options(1) = 1;
  if length(params) <= 20
    options(9) = 1;
  end
end
options(14) = iters;

params = scg('gplvmKernelObjective', params,  options, ...
            'gplvmKernelGradient', model, prior);

kernParams = params(1:model.kern.nParams);
xVals = params(model.kern.nParams+1:end);

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
model.kern = kernExpandParam(model.kern, kernParams);  