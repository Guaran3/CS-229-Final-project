
% DEMTWOSTEST Present test data to the twos models with some missing pixels.
%
%	Description:
%	% 	demTwosTest.m CVS version 1.3
% 	demTwosTest.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

rand('seed', 1e5)
randn('seed', 1e5)
dataset = 'twos';
[Y, lbls] = lvmLoadData(dataset);
number = 2;
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);


% For efficiency, probit doesn't handle missing values.
% Therefore use a 2 category ordered categorical model which is equivalent.
model.noise.type = 'ordered';
model.noise.C = 2;
model.noise.variance = model.noise.sigma2;
model.noise.widths = [];
model.y = (model.y+1)/2;

load twoTest
Ytest = a; 
missing = rand(size(Ytest))>0.8;
missingIndex = find(missing);
Ymiss = Ytest;
Ymiss(missingIndex) = NaN;

Ymisspres = Ymiss*2 - 1;
Ymisspres(missingIndex) = 0;

options = optOptions;
options(14) = 500;

prior.type = 'gaussian';
prior = priorParamInit(prior);
prior.precision = 1;
numData = size(Ytest, 1);
numSeed = 10;
for j = 1:numSeed
  YpredBin{j} = Ymiss;
end
for i = 1:numData;
  indices = find(isnan(Ymiss(i, :)));
  for j = 1:numSeed;
    randn('seed', j*1e5);
    rand('seed', j*1e5);
    
    x = randn(1, 2);
    x = scg('pointNegLogLikelihood', x,  options, ...
            'pointNegGradX', Ymiss(i, :), model, prior);
    ynew = ivmOut(model, x);
    YpredBin{j}(i, indices) = ynew(indices);
    pointLlBin(i, j) = - pointNegLogLikelihood(x, YpredBin{j}(i, :), model, prior);
  end
  total(i) = length(indices);
  blackTotal(i) = sum(Ytest(i, indices)==0);
  fprintf(['Finished %d, Ave Ll %2.4f\n'], i, mean(pointLlBin(i, :)));
  [void, indexBin(i)] = max(pointLlBin(i, :));
end

number = 1;
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);


% For efficiency Gaussian doesn't handle missing values.
% Therefore use mgaussian.
model.noise.type = 'mgaussian';
model.noise.sigma2 = repmat(model.noise.sigma2, 1, model.noise.numProcess);

prior.type = 'gaussian';
prior = priorParamInit(prior);
prior.precision = 1;

for j = 1:numSeed
  YpredGauss{j} = Ymiss;
end
YpredInk = Ymiss;
for i = 1:numData;
  indices = find(isnan(Ymiss(i, :)));
  YpredInk(i, indices) = 0;
  for j = 1:numSeed;
    randn('seed', j*1e5);
    rand('seed', j*1e5);
    
    x = randn(1, 2);
    x = scg('pointNegLogLikelihood', x,  options, ...
            'pointNegGradX', Ymiss(i, :), model, prior);
    ynew = ivmOut(model, x)>0;
    YpredGauss{j}(i, indices) = ynew(indices);
    pointLlGauss(i, j) = - pointNegLogLikelihood(x, YpredGauss{j}(i, :), model, prior);
  end
  fprintf(['Finished %d, Ave Ll %2.4f\n'], i, mean(pointLlGauss(i, :)));
  [void, indexGauss(i)] = max(pointLlGauss(i, :));
end


numDigits = 20;
a = randperm(numData);
aChoose = a(1:numDigits);
val = 1;
spacing = 2;
fullMat = [];
for i = 1:numDigits
  mat =  [reshape(1-Ytest(aChoose(i), :), 8, 8)'; ...
              repmat(val, spacing, 8); ...
              reshape(.5-.5*Ymisspres(aChoose(i), :), 8, 8)';  ...
              repmat(val, spacing, 8);  ...
              reshape(1-YpredInk(aChoose(i), :), 8, 8)'; ...
              repmat(val, spacing, 8);  ...
              reshape(1-YpredGauss{indexGauss(i)}(aChoose(i), :), 8, 8)'; ...
              repmat(val, spacing, 8);  ...
              reshape(1-YpredBin{indexBin(i)}(aChoose(i), :), 8, 8)'
             ];
  if i == 1
    fullMat = mat;
  else
    fullMat = [fullMat repmat(val, 4*(spacing+8)+8, 4*spacing) mat];
  end
end
clf

imagesc(fullMat); 
pos = get(gcf, 'paperposition');
pos(4) = pos(3)*5/30;
set(gcf, 'paperposition', pos)
pos = get(gcf, 'position');
pos(4) = pos(3)*5/30;
set(gcf, 'position', pos)
axis off
axis equal
colormap([0 0 0; 1 0 0; 1 1 1])

for i = 1:numData
  indices = find(isnan(Ymiss(i, :)));
  yTest = Ytest(i, indices);
  numTest(i) = length(yTest);
  correctBin(i) = sum(YpredBin{indexBin(i)}(i, indices)==yTest);
  correctGauss(i) = sum(YpredGauss{indexGauss(i)}(i, indices)==yTest);
  correctInk(i) = sum(YpredInk(i, indices)==yTest);
end
fprintf('Correct no ink: %2.4f\n', sum(correctInk)/sum(numTest));
fprintf('Correct Gaussian: %2.4f\n', sum(correctGauss)/sum(numTest));
fprintf('Correct binary: %2.4f\n', sum(correctBin)/sum(numTest));

save demTwosTest correctInk correctBin correctGauss numTest YpredBin YpredGauss YpredInk Ymiss Ytest