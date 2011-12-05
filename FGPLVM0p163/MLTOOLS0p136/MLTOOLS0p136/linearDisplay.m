function linearDisplay(model, spacing)

% LINEARDISPLAY Display a linear model.
%
%	Description:
%	linearDisplay(model, spacing)
%% 	linearDisplay.m CVS version 1.1
% 	linearDisplay.m SVN version 24
% 	last update 2006-06-07T10:45:27.000000Z

if nargin > 1
  spacing = repmat(32, 1, spacing);
else
  spacing = [];
end
spacing = char(spacing);
fprintf(spacing);
fprintf('Model model:\n')
fprintf(spacing);
fprintf('  Input dimension: %d\n', model.inputDim);
fprintf(spacing);
fprintf('  Output dimension: %d\n', model.outputDim);
