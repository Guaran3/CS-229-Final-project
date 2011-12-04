function [model, lbls] = gplvmReadFromFID(FID)

% GPLVMREADFROMFID Load from a FID produced by the C++ implementation.
%
%	Description:
%	[model, lbls] = gplvmReadFromFID(FID)
%% 	gplvmReadFromFID.m CVS version 1.2
% 	gplvmReadFromFID.m SVN version 322
% 	last update 2009-04-17T21:36:27.000000Z

try
  version = readVersionFromFID(FID);
catch
  if strcmp(lasterr, 'Incorrect file format')
    version = readDoubleFromFID(FID, 'gplvmVersion');
  else
    error(lasterr)
  end
end

if version > 0.2 
  error('Incorrect file version.')
end

if version>0.11
  baseType = readStringFromFID(FID, 'baseType')
  if ~strcmp(baseType, 'datamodel')
    error('Incorrect base type in file.')
  end
  type = readStringFromFID(FID, 'type')
  if ~strcmp(type, 'gplvm')
    error('Incorrect type in file.')
  end
end
numData = readIntFromFID(FID, 'numData')
if version > 0.11 
  strv = 'outputDim';
else
  strv = 'numProcesses';
end
dataDim = readIntFromFID(FID, strv)
if version > 0.11 
  strv = 'inputDim';
else
  strv = 'latentDim';
end
latentDim = readIntFromFID(FID, strv);
if(version>0.1)
  latentRegularised = readBoolFromFID(FID, 'latentRegularised');
  backConstrained = readBoolFromFID(FID, 'backConstrained');
  dynamicsLearnt = readBoolFromFID(FID,  'dynamicsLearnt');
else
  latentRegularised = 0;
  backConstrained = 0;
  dynamicsLearnt = 0;
end
if version > 0.11
  kern = modelReadFromFID(FID);
else
  kern = kernReadFromFID(FID, version);
end
if dynamicsLearnt
  if version > 0.11
    dynKern = modelReadFromFID(FID);
  else
    dynKern = kernReadFromFID(FID, version);
  end
end
if version > 0.11
  noise = modelReadFromFID(FID);
else
  noise = noiseReadFromFID(FID, version);
end

labelsPresent = 0;
labels = ones(numData, 1);
lineStr = getline(FID);
tokens = tokenise(lineStr,',');
for i=1:length(tokens)
  subTokens = tokenise(tokens{i}, ':');
  if strcmp(subTokens{1}, 'Y')
    if str2num(subTokens{2})~=dataDim
      error('Incorrect file format.');
    end
  elseif strcmp(subTokens{1}, 'X')
    if str2num(subTokens{2})~=latentDim
      error('Incorrect file format.');
    end
  elseif strcmp(subTokens{1}, 'labels')
    labelsPresent = 1;
    if str2num(subTokens{2})~=1
      error('Incorrect file format.');
    end
  else
    error('Incorrect file format.');
  end
end

X = zeros(numData, latentDim);
y = zeros(numData, dataDim);

for i=1:numData
  lineStr = getline(FID);
  tokens = tokenise(lineStr);
  for j=1:dataDim
    y(i, j) = str2num(tokens{j});
  end
  for j=1:latentDim
    X(i, j) = str2num(tokens{j+dataDim});
  end
  if labelsPresent
    labels(i) = str2num(tokens{dataDim+latentDim+1});
  end
end
if(~strcmp(noise.type, 'scale'))
  error('Can only load noise of type scale.')
end
[ivmInfo.m, ivmInfo.beta] = scaleNoiseSites(noise, [], [], [], [], y);
ivmInfo.I = 1:size(X, 1);
ivmInfo.J=[];

model = ivmReconstruct(kern, noise, ivmInfo, X, y);
lbls=[];
if labelsPresent
  minLbl = min(labels);
  maxLbl = max(labels);
  counter = 0;
  for i=minLbl:maxLbl
    counter = counter + 1;
    lbl = zeros(size(labels));
    lbl(find(labels==i))=1;
    lbls = [lbls lbl];
  end
end
