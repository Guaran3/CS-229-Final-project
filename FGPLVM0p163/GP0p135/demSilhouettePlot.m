
% DEMSILHOUETTEPLOT
%
%	Description:
%	% 	demSilhouettePlot.m SVN version 327
% 	last update 2008-12-01T07:46:53.000000Z

% Show prediction for test data.
yPred = modelOut(model, XTest);
xyzankurAnimCompare(yPred, yTest);

yDiff = (yPred - yTest);
rmsError = sqrt(sum(sum(yDiff.*yDiff))/prod(size(yDiff)));

counter = 0;
if printDiagram
  ind = 1:27:size(yPred, 1)
  for i = ind
    counter = counter + 1;
    figure
    handle = xyzankurVisualise(yPred(i,:), 1);
    printPlot([fileBaseName '_' num2str(counter)], '../tex/diagrams', '../html') 
  end
end
