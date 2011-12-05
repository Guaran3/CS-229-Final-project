function model = ivmOptimiseKernel(model, display, iters);

% IVMOPTIMISEKERNEL Optimise the kernel parameters.
%
%	Description:
%
%	IVMOPTIMISEKERNEL(MODEL, DISPLAY, ITERS) optimises the kernel
%	parameters of the IVM model.
%	 Arguments:
%	  MODEL - the model for which the kernel parameters are to be
%	   optimised.
%	  DISPLAY - how much to display during optimisation (defaults to
%	   level 1).
%	  ITERS - how many iterations of optimisation to use (defaults to
%	   500).
%	
%
%	See also
%	OPTIMISEPARAMS, DEFAULTOPTIONS, IVMKERNELOBJECTIVE, IVMKERNELGRADIENT


%	Copyright (c) 2004, 2005 Neil D. Lawrence
% 	ivmOptimiseKernel.m version 1.9


if nargin < 3
  iters = 500;
  if nargin < 2
    display = 1;
  end
end
options = defaultOptions;
if display
  options(1) = 1;
end
options(14) = iters;


model = optimiseParams('kern', 'scg', 'ivmKernelObjective', ...
                       'ivmKernelGradient', options, model);
  