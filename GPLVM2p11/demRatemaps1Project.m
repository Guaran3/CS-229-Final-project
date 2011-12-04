
% DEMRATEMAPS1PROJECT
%
%	Description:
%	% 	demRatemaps1Project.m CVS version 1.3
% 	demRatemaps1Project.m SVN version 326
% 	last update 2009-04-17T21:39:23.000000Z

rand('seed', 1e5)
randn('seed', 1e5)
dataset = 'ratemaps';
[Y, lbls] = lvmLoadData(dataset);
% Select a small subset of the data.
Y = ratemap2Diffrep(Y);

number = 1;
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

Ytest = loadRateMap('../data/ratemaps');
% THis is "The horse kicks the rider."
Ytest = Ytest(:, 20130:20620)';
Ytest = ratemap2Diffrep(Ytest);
% Set average of each signal to zero.
options = optOptions;
options(14) = 500;

prior.type = 'gaussian';
prior = priorParamInit(prior);
prior.precision = 1;
numData = size(Ytest, 1);
numSeed = 5;
for j = 1:numSeed

  randn('seed', j*1e5);
  rand('seed', j*1e5);
  initX = randn(1, 2);
  x{j} = zeros(numData, 2);
  for i = 1:numData;
    x{j}(i, :) = scg('pointNegLogLikelihood', initX,  options, ...
                  'pointNegGradX', Ytest(i, :), model, prior);
    initX=x{j}(i, :);
    pointLlBin(i, j) = - pointNegLogLikelihood(x{j}(i, :), Ytest(i, ...
                                                      :), model, prior);
    fprintf(['Finished %d, Ll %2.4f\n'], i, mean(pointLlBin(i, j)));
  end
end
[void, ind] = max(mean(pointLlBin));
Yapprox = ivmOut(model, x{ind});

save(['dem' dataset num2str(number) 'Project.mat'], 'x', ...
     'pointLlBin', 'ind', 'Yapprox', 'Ytest');
figure
subplot(2, 1, 1);
imagesc(diffrep2Ratemap(Ytest));
subplot(2, 1, 2);
imagesc(diffrep2Ratemap(Yapprox));
