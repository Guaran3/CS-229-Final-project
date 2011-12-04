function [ax] = gplvmFantasyPlot(model, visualiseFunction, axesWidth, yAxesRatio, varargin);

% GPLVMFANTASYPLOT Block plot of fantasy data.
%
%	Description:
%	[ax] = gplvmFantasyPlot(model, visualiseFunction, axesWidth, yAxesRatio, varargin);
%% 	gplvmFantasyPlot.m CVS version 1.5
% 	gplvmFantasyPlot.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

x1 = linspace(min(model.X(:, 1))*1.1, max(model.X(:, 1))*1.1, floor(yAxesRatio/axesWidth));
x2 = linspace(min(model.X(:, 2))*1.1, max(model.X(:, 2))*1.1, floor(1/axesWidth));
[X1, X2] = meshgrid(x1, x2);
XTest = [X1(:), X2(:)];
[mu, varsigma] = ivmPosteriorMeanVar(model, XTest);
testY = noiseOut(model.noise, mu, varsigma);
testYPlot = testY;
testYPlot(find(varsigma>prctile(varsigma(:, 1), 25))) =NaN;

figure(1)
clf
% Create the plot for the data
clf
posit = [0.05 0.05 0.9 0.9];
ax = axes('position', posit);
hold on
%[c, h] = contourf(X1, X2, log10(reshape(1./varsigma(:, 1), size(X1))), 128); 
%shading flat
colormap gray;
%colorbar
xLim = [min(XTest(:, 1)) max(XTest(:, 1))];
yLim = [min(XTest(:, 2)) max(XTest(:, 2))];
set(ax, 'xLim', xLim);
set(ax, 'yLim', yLim);


widthVal = axesWidth*(xLim(2) - xLim(1))/posit(3);
heightVal = axesWidth*(yLim(2) - yLim(1))/posit(4);
visitOrder = 1:size(XTest, 1);
% Plot the images
for i = visitOrder
  %while ~isempty(visitOrder)
  %i = visitOrder(1);
  if XTest(i, 1) > xLim(1) & XTest(i, 1) < xLim(2) ...
    & XTest(i, 2) > yLim(1) & XTest(i, 2) < yLim(2)
    point = invGetNormAxesPoint(XTest(i, :), ax);
    x = point(1);
    y = point(2);
    
    digitAxes(i) =  axes('position', ...
			 [x - axesWidth/2 ...
		    y - axesWidth/2 ...
		    axesWidth ...
		    axesWidth]);
    handle = feval(visualiseFunction, testY(i, :), varargin{:});
    colormap gray
    axis image
    axis off
    
%    removePoints = find(abs(XTest(visitOrder, 1) - XTest(i, 1)) < widthVal ...
%			&  abs(XTest(visitOrder, 2) - XTest(i, 2)) < heightVal);
%    visitOrder(removePoints) = [];    
  else
    visitOrder(1) = [];
  end
end


set(ax, 'fontname', 'arial');
set(ax, 'fontsize', 20);

