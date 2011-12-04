function gplvmVisualise(model, YLbls, ...
			visualiseFunction, visualiseModify, varargin)

% GPLVMVISUALISE Visualise the manifold.
%
%	Description:
%	gplvmVisualise(model, YLbls, ...
%			visualiseFunction, visualiseModify, varargin)
%% 	gplvmVisualise.m CVS version 1.9
% 	gplvmVisualise.m SVN version 322
% 	last update 2009-04-16T14:24:55.000000Z

global visualiseInfo

figure(1)
clf
visualiseInfo.plotAxes = lvmScatterPlot(model, YLbls);

visualiseInfo.latentHandle = line(0, 0, 'markersize', 20, 'color', ...
                                  [0 0 0], 'marker', '.', 'visible', ...
                                  'on', 'erasemode', 'xor');

visualiseInfo.runDynamics = false;
% Set up the X limits and Y limits of the main plot
xLim = [min(model.X(:, 1)) max(model.X(:, 1))];
xSpan = xLim(2) - xLim(1);
xLim(1) = xLim(1) - 0.05*xSpan;
xLim(2) = xLim(2) + 0.05*xSpan;
xSpan = xLim(2) - xLim(1);

yLim = [min(model.X(:, 2)) max(model.X(:, 2))];
ySpan = yLim(2) - yLim(1);
yLim(1) = yLim(1) - 0.05*ySpan;
yLim(2) = yLim(2) + 0.05*ySpan;
ySpan = yLim(2) - yLim(1);

set(visualiseInfo.plotAxes, 'XLim', xLim)
set(visualiseInfo.plotAxes, 'YLim', yLim)

visualiseInfo.clicked = 0;

visualiseInfo.digitAxes = [];
visualiseInfo.digitIndex = [];

% Set the callback function
set(gcf, 'WindowButtonMotionFcn', 'lvmClassVisualise(''move'')')
set(gcf, 'WindowButtonDownFcn', 'lvmClassVisualise(''click'')')

figure(2)
clf

if strcmp(visualiseFunction(1:5), 'image') & length(varargin)>0
  set(gcf, 'menubar', 'none')
  xPixels = 115;
  yPixels = 115;
  set(gcf, 'position', [232 572 xPixels yPixels/varargin{1}(1)*varargin{1}(2)])
  visualiseInfo.visualiseAxes = subplot(1, 1, 1);
  xWidth = varargin{1}(1)/xPixels;
  yHeight = varargin{1}(2)/yPixels;
  set(visualiseInfo.visualiseAxes, 'position', [0.5-xWidth/2 0.5-yHeight/2 xWidth yHeight])
else
  visualiseInfo.visualiseAxes =subplot(1, 1, 1);
end
visData = zeros(1,size(model.y, 2));
if(strcmp(visualiseFunction(1:5), 'image'))
  visData(1) = min(min(model.y));
  visData(end) = max(max(model.y));
else
  [void, indMax]= max(sum((model.y.*model.y), 2));
  visData = model.y(indMax, :);
end

visHandle = feval(visualiseFunction, visData, varargin{:});
set(visHandle, 'erasemode', 'xor')
colormap gray

% Pass the data to visualiseInfo
visualiseInfo.model = model;
visualiseInfo.varargin = varargin;
if isstr(visualiseModify)
  visualiseModify = str2func(visualiseModify);
end
visualiseInfo.visualiseModify = visualiseModify;
visualiseInfo.visHandle = visHandle;
hold off




