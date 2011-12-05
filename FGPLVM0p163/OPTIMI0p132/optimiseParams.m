function model = optimiseParams(component, optimiser, objective, ...
                                gradient, options, model);

% OPTIMISEPARAMS Optimise parameters.
%
%	Description:
%	model = optimiseParams(component, optimiser, objective, ...
%                                gradient, options, model);
%

%	Copyright (c) 2007 Neil D. Lawrence
% 	optimiseParams.m version 1.5



params = feval([component 'ExtractParam'], getfield(model, component));

if options(1)
  if length(params) > 20
    options(9) = 0;
  else
    options(9) = 1;
  end
end

params = feval(optimiser, objective, params, options, gradient, model);

model = setfield(model, ...
                 component, ...
                 feval([component 'ExpandParam'], ...
                       getfield(model, component), ...
                       params));
