
% DEMSWISSROLLFULLLLE1 Demonstrate LLE on the oil data.
%
%	Description:
%	% 	demSwissRollFullLle1.m SVN version 97
% 	last update 2008-10-05T21:17:30.000000Z

[Y, lbls] = lvmLoadData('swissRollFull');

options = lleOptions(4, 2);
model = lleCreate(2, size(Y, 2), Y, options);
model = lleOptimise(model);

lvmScatterPlotColor(model, model.Y(:, 2));

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, model.Y(:, 2), 'SwissRollFull', 1, true);
end
