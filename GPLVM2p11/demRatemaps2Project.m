
% DEMRATEMAPS2PROJECT
%
%	Description:
%	% 	demRatemaps2Project.m CVS version 1.3
% 	demRatemaps2Project.m SVN version 326
% 	last update 2009-04-17T21:36:51.000000Z

rand('seed', 1e5)
randn('seed', 1e5)
dataset = 'ratemaps';
[Y, lbls] = lvmLoadData(dataset);
% Select a small subset of the data.
Y = ratemap2Diffrep(Y);
for i = 1:size(Y, 2);
  va(i) = var(Y(find(~isnan(Y(:, i))), i));
  Y(:, i) = Y(:, i)/sqrt(va(i));
end

number = 2;
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

Ytest = loadRateMap('../data/ratemaps');
% THis is "The horse kicks the rider."
Ytest = Ytest(:, 1:130)';
%Ytest = Ytest(:, 20520:20620)';
%Ytest = Ytest(:, 20220:20290)';
Ytest = ratemap2Diffrep(Ytest);
for i = 1:size(Ytest, 2);
  Ytest(:, i) = Ytest(:, i)/sqrt(va(i));
end
% Set average of each signal to zero.
options = optOptions;
options(14) = 500;

% For efficiency Gaussian doesn't handle missing values.
% Therefore use mgaussian.
model.noise.type = 'mgaussian';
model.noise.sigma2 = repmat(model.noise.sigma2, 1, model.noise.numProcess);
%model.noise.sigma2(:, 1) = model.noise.sigma2(:, 1)*2;

prior.type = 'gaussian';
prior = priorParamInit(prior);
prior.precision = 1;
numData = size(Ytest, 1);
numSeed = 10;
for j = 1:numSeed

  randn('seed', j*1e5);
  rand('seed', j*1e5);
  initX = randn(1, 2);
  xVals{j} = zeros(numData, 2);
  for i = 1:numData;

    if j > 1 & max(pointLlBin(i, 1:j-1)) > -90;
      [pointLlBin(i, :), index] = min(pointLlBin(i, 1:j-1));
      xVals{j}(i, :) = xVals{index}(i, :);      
    elseif j > 5 & max(pointLlBin(i, 1:j-1)) > -100;
      [pointLlBin(i, :), index] = min(pointLlBin(i, 1:j-1));
      xVals{j}(i, :) = xVals{index}(i, :);      
    else
      prevX = initX;
      xOne = scg('pointNegLogLikelihood', initX,  options, ...
                           'pointNegGradX', Ytest(i, :), model, prior);
      initX = randn(1, 2);
      xTwo = scg('pointNegLogLikelihood', initX,  options, ...
                           'pointNegGradX', Ytest(i, :), model, prior);
      llOne = - pointNegLogLikelihood(xOne, Ytest(i, ...
                                                        :), model, prior);
      llTwo = - pointNegLogLikelihood(xTwo, Ytest(i, ...
                                                        :), model, prior);

      % Use a Cauchy prior centred on previous point.
      cauchParam = 0.1
      llOneV = llOne - log(1+sum(((xOne -prevX)/cauchParam).^2)) - log(pi*cauchParam);
      llTwoV = llTwo - log(1+sum(((xTwo -prevX)/cauchParam).^2)) - log(pi*cauchParam);
      [void, useInd] = max([llOneV llTwoV]);
      if useInd == 1
        xVals{j}(i, :) = xOne;
        pointLlBin(i, j) = llOne;
      else
        xVals{j}(i, :) = xTwo;
        pointLlBin(i, j) = llTwo;
      end
      initX= xVals{j}(i, :);
      fprintf(['Finished %d, Ll %2.4f\n'], i, pointLlBin(i,j));
    end
  end
end
[void, ind] = max(pointLlBin, [], 2);
X = zeros(size(Ytest, 1), 2);
for i = 1:size(Ytest, 1)
  X(i, :) = xVals{ind(i)}(i, :);
end
Yapprox = ivmOut(model, X);
for i = 1:size(Ytest, 2);
  Ytest(:, i) = Ytest(:, i)*sqrt(va(i));
end
for i = 1:size(Yapprox, 2);
  Yapprox(:, i) = Yapprox(:, i)*sqrt(va(i));
end

save(['dem' dataset num2str(number) 'ProjectEx.mat'], 'xVals', 'X', ...
     'pointLlBin', 'ind', 'Yapprox', 'Ytest');
figure
subplot(2, 1, 1);
imagesc(flipud(diffrep2Ratemap(Ytest)'));
subplot(2, 1, 2);
imagesc(flipud(diffrep2Ratemap(Yapprox)'));
