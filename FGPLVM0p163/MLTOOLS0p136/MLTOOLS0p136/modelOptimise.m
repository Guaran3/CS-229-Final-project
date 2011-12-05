function model = modelOptimise(model, varargin)

% MODELOPTIMISE Optimise the given model.
%
%	Description:
%
%	MODEL = MODELOPTIMISE(MODEL, X, Y, DISPLAY, ITERS) is a wrapper
%	function that optimises a given model.
%	 Returns:
%	  MODEL - the optimised model.
%	 Arguments:
%	  MODEL - the model to be optimised.
%	  X - input value to model.
%	  Y - target value for model.
%	  DISPLAY - whether or not to display optimization values.
%	  ITERS - number of iterations.
%	
%	
%
%	See also
%	MODELOBJECTIVE, MODELGRADIENT


%	Copyright (c) 2006 Neil D. Lawrence


%	With modifications by Carl Henrik Ek 2007
% 	modelOptimise.m CVS version 1.6
% 	modelOptimise.m SVN version 831
% 	last update 2010-06-03T15:22:04.000000Z

if nargin < 2
  varargin = {}
end
fhandle = [model.type 'Optimise'];
if exist(fhandle)==2
  fhandle = str2func(fhandle);
  model = fhandle(model, varargin{:});
else
  if ~isfield(model, 'display')
    if length(varargin)< 3
      display = 1;
    else
      display = varargin{3};
    end    
    if length(varargin)<4
      iters = 500;
    else
      iters = varargin{4};
    end
    if length(varargin)<2 | isempty(varargin{2})
    else
      model.y = varargin{2};
    end
    if length(varargin)<1 | isempty(varargin{1})
    else
      model.X = varargin{1};
    end
  end

  options = optOptions;
  options(14) = iters;
  options(9) = 0;
  options(1) = display;
  options(2) = 1e-6;
  
  
  params = modelExtractParam(model);
  if(~isempty(params))
    if isfield(model, 'optimiser')
      optim = str2func(model.optimiser);
    else
      optim = str2func('conjgrad');
    end
    
    params = optim('modelObjective', params,  options, ...
                   'modelGradient', model);
    
    model = modelExpandParam(model, params);
  else
    warning('This Model Has No Parameters To Optimise');
  end
end


