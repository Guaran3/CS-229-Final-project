
% DEMSWISSROLLLLE1 Demonstrate LLE on the oil data.
%
%	Description:
%	% 	demSwissRollLle1.m SVN version 560
% 	last update 2009-11-04T23:34:26.000000Z

[Y, lbls] = lvmLoadData('swissRoll');

options = lleOptions(4);
model = lleCreate(2, size(Y, 2), Y, options);
model = lleOptimise(model, 2);

lvmScatterPlotColor(model, model.Y(:, 2));

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, model.Y(:, 2), 'SwissRoll', 1, true);
end
