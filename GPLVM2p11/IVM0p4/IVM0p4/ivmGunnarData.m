function model = ivmGunnarData(dataSet, dataNum, kernelType, invWidth, dVal)

% IVMGUNNARDATA Script for running experiments on Gunnar data.
%
%	Description:
%	Note that for this script to work, you need to have
%	placed Gunnar Raetsch's benchmark data sets in the correct
%	directory under the DATASETS toolbox (see
%	http://ida.first.fraunhofer.de/projects/bench/benchmarks.htm for
%	the data).
%
%	MODEL = IVMGUNNARDATA(DATASET, DATANUM, KERNELTYPE, INVWIDTH, DVAL)
%	is a script for running experiments on Gunnar Raetsch's benchmark
%	data sets.
%	 Returns:
%	  MODEL - the model learnt on the data.
%	 Arguments:
%	  DATASET - the data set to be trained on.
%	  DATANUM - the partition to be trained.
%	  KERNELTYPE - the kernel type to be used.
%	  INVWIDTH - inverse width of the kernel being used.
%	  DVAL - active set size to be used.
%	
%
%	See also
%	MAPLOADDATA


%	Copyright (c) 2005 Neil D. Lawrence
% 	ivmGunnarData.m version 1.1


% Load the data
HOME = getenv('HOME');
fprintf('Dataset: %s, number %d, inverse width %2.4f\n', dataSet, dataNum, invWidth)
fs = filesep;
baseDir = [HOME filesep 'datasets' filesep 'gunnar' filesep dataSet filesep];
[X, y, Xtest, ytest] = mapLoadData(['gunnar' ':' dataSet ':' ...
                    num2str(dataNum)]);

% Get the default options
options = ivmOptions;
% Modify kernel type and number of active points.
options.kern = kernelType;
options.numActive = dVal;
options.display = 0;
model = ivmCreate(size(X, 1), size(y, 2), X, y, options);
model.kern.comp{1}.inverseWidth = invWidth;
fprintf('Initial model:\n');
ivmDisplay(model);

% Do 15 iterations
for i = 1:15
    % Select the active set.
  model = ivmOptimiseIVM(model, options.display);
  % Optimise the kernel parameters.
  model = ivmOptimiseKernel(model, options.display, 100);
  fprintf('Iteration %d\n', i);
  ivmDisplay(model);
end
model = ivmOptimiseIVM(model, options.display);
% Display the final model.
fprintf('Final model:\n');
ivmDisplay(model);

yPred = ivmOut(model, Xtest);
classError = 1- sum(ytest ==yPred)/length(ytest);

ll = ivmApproxLogLikelihood(model);
fprintf('Test Error %2.4f\n', classError);
fprintf('Model likelihood %2.4f\n', ll);
invWidthStr = num2str(invWidth);
ind = find(invWidthStr==46);
invWidthStr(ind) = 'p';
[kern, noise, ivmInfo] = ivmDeconstruct(model);
save(['ivm' dataSet num2str(dataNum) kernelType{1} invWidthStr], 'classError', 'll', ...
      'kern', 'noise', 'ivmInfo')
     