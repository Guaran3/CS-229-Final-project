
% DEMSILHOUETTEAVERAGE Shows the average of the poses.
%
%	Description:
%	% 	demSilhouetteAverage.m SVN version 327
% 	last update 2008-11-30T22:05:47.000000Z
% FORMAT
% DESC show the average of the training poses from Agarwal and Triggs.
%
% SEEALSO : demSilhouetteGp1, demSilhouetteGp2
% 
% COPYRIGHT : Neil D. Lawrence, 2008


randn('seed', 1e7)
rand('seed', 1e7)

dataSetName = 'silhouette';

capName = dataSetName;;
capName(1) = upper(capName(1));

% load data
[X, y, XTest, yTest] = mapLoadData(dataSetName);

yPred = repmat(mean(y), size(yTest, 1), 1);
xyzankurAnimCompare(yPred, yTest);

yDiff = (yPred - yTest);
rmsError = sqrt(sum(sum(yDiff.*yDiff))/prod(size(yDiff)));

counter = 0;
if printDiagram
  fileBase = ['dem' capName 'Average'];
  figure
  handle = xyzankurVisualise(yPred(1, :), 1);
  printPlot([fileBase], '../tex/diagrams', '../html') 
end
