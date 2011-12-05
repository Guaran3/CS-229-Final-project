
% DEMOILLLE2 Demonstrate LLE on the oil data.
%
%	Description:
%	% 	demOilLle2.m SVN version 99
% 	last update 2008-10-05T21:51:55.000000Z

[Y, lbls] = lvmLoadData('oil');

options = lleOptions(8, 2);
model = lleCreate(2, size(Y, 2), Y, options);
model = lleOptimise(model);

lvmScatterPlot(model, lbls);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, 'Oil', 2);
end

errors = lvmNearestNeighbour(model, lbls);
