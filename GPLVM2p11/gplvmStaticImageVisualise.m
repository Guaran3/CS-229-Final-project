function gplvmStaticImageVisualise(model, visualiseFunction, axesWidth, varargin)

% GPLVMSTATICIMAGEVISUALISE Generate a scatter plot of the images without overlap.
%
%	Description:
%	gplvmStaticImageVisualise(model, visualiseFunction, axesWidth, varargin)
%% 	gplvmStaticImageVisualise.m CVS version 1.6
% 	gplvmStaticImageVisualise.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

% set random seeds
randn('seed', 1e5)
rand('seed', 1e5)

colordef white 

% Turn Y into grayscale
[plotAxes, data] = gplvmScatterPlot(model, []);

xLim = get(plotAxes, 'xLim');
yLim = get(plotAxes, 'yLim');
posit = get(plotAxes, 'position');

widthVal = axesWidth*(xLim(2) - xLim(1))/posit(3);
heightVal = axesWidth*(yLim(2) - yLim(1))/posit(4);
numData = size(model.X, 1);

visitOrder = randperm(numData);
initVisitOrder = visitOrder;

% Plot the images
while ~isempty(visitOrder)
  i = visitOrder(1);
  if model.X(i, 1) > xLim(1) & model.X(i, 1) < xLim(2) ...
    & model.X(i, 2) > yLim(1) & model.X(i, 2) < yLim(2)
    point = invGetNormAxesPoint(model.X(i, :), plotAxes);
    x = point(1);
    y = point(2);
    
    digitAxes(i) =  axes('position', ...
			 [x - axesWidth/2 ...
		    y - axesWidth/2 ...
		    axesWidth ...
		    axesWidth]);
    handle = feval(visualiseFunction, model.y(i, :), varargin{:});
    colormap gray
    axis image
    axis off
    
    removePoints = find(abs(model.X(visitOrder, 1) - model.X(i, 1)) < widthVal/2 ...
			&  abs(model.X(visitOrder, 2) - model.X(i, 2)) < heightVal);
    visitOrder(removePoints) = [];    
  else
    visitOrder(1) = [];
  end
end
set(plotAxes, 'xlim', xLim);
set(plotAxes, 'ylim', yLim);
set(data, 'visible', 'off');
%ticks = [-4 -2 0 2 4];
%set(plotAxes, 'xtick', ticks)
%set(plotAxes, 'ytick', ticks)
