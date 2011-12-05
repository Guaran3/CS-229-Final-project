
% DEMSTICKGP1 Demonstrate Gaussian processes for regression on stick man data.
%
%	Description:
%
%	DEMSTICKGP1 runs a simple regression on the stick man data.
%	
%
%	See also
%	GPCREATE, DEMINTERPOLATION


%	Copyright (c) 2008 Neil D. Lawrence
% 	demStickGp1.m SVN version 327
% 	last update 2008-11-27T18:37:39.000000Z

randn('seed', 1e7)
rand('seed', 1e7)

dataSetName = 'stick';
experimentNo = 1;

% load data
[y, lbls] = lvmLoadData(dataSetName);

% load connectivity matrix
[void, connect] = mocapLoadTextData([datasetsDirectory 'run1']);

% Data is downsampled from 120 frames per second.
fps = 120/4;
t = (0:size(y, 1)-1)'/fps;
% Predict Left Ankle X, Y and Z
outputIndex = [7 8 9];
indices = [1:10 20:55];
testIndex = 1:size(y, 1);
testIndex(indices) = [];
yTrain = y(indices, outputIndex);
tTrain = t(indices, 1);
% Set up the model
options = gpOptions('ftc');

% Scale outputs to variance 1.
options.scale2var1 = true;

% Use the full Gaussian process model.
q = size(tTrain, 2);
d = size(yTrain, 2);
model = gpCreate(q, d, tTrain, yTrain, options);

display = 1;
iters = 1000;

model = gpOptimise(model, display, iters);
modelDisplay(model)

% Save results
capName = dataSetName;;
capName(1) = upper(capName(1));
save(['dem' capName 'Gp' num2str(experimentNo) '.mat'], 'model');


% Plot results
fillColor = [0.7 0.7 0.7];
tTest = linspace(0, 2, 200)';
[mu, varSigma] = gpPosteriorMeanVar(model, tTest);

for i = 1:length(outputIndex);
  figure
  fill([tTest; tTest(end:-1:1)], ...
       [mu(:, i); mu(end:-1:1, i)] ...
       + 2*[sqrt(varSigma(:, i)); -sqrt(varSigma(end:-1:1, i))], ...
       fillColor,'EdgeColor',fillColor)
  hold on;
  plot(t(testIndex), y(testIndex, outputIndex(i)), 'ko');
  b=plot(tTrain, yTrain(:, i), 'k.');
  set(b, 'Markersize', 15);
  a = plot(tTest, mu(:, i), 'k-');
  set(gca, 'xlim', [0 2])
  set(a, 'linewidth', 2);
  
  zeroAxes(gca, [], 10, 'arial')
  if exist('printDiagram') && printDiagram
    fileName = ['dem' capName 'Gp' num2str(experimentNo) 'Out' num2str(i)];
    printPlot(fileName, '../tex/diagrams', '../html');
  end
end