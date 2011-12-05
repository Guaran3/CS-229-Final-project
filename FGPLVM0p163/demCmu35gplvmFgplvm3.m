
% DEMCMU35GPLVMFGPLVM3 Learn a GPLVM on CMU 35 data set.
%
%	Description:
%	% 	demCmu35gplvmFgplvm3.m SVN version 536
% 	last update 2009-09-29T16:27:50.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

% Get the sequence numbers.
[Y, lbls] = lvmLoadData('cmu35WalkJog');
seq = cumsum(sum(lbls)) - [1:31];

dataSetName = 'cmu35gplvm';
experimentNo = 3;

% load data
[Y, lbls, Ytest, lblstest] = lvmLoadData(dataSetName);

% Set up model
options = fgplvmOptions('fitc');
options.optimiser = 'conjgrad';
options.back = 'mlp';
options.backOptions = mlpOptions(10);
options.numActive = 100;
options.fixInducing = 1;
options.fixIndices = round(linspace(1, size(Y, 1), options.numActive));
latentDim = 5;

d = size(Y, 2);
model = fgplvmCreate(latentDim, d, Y, options);
model.bias = mean(model.y);
model.scale = std(model.y);

% Add dynamics model.
optionsDyn = gpOptions('fitc');
optionsDyn.numActive = 100;
optionsDyn.fixInducing = 1;
optionsDyn.kern = kernCreate(model.X, {'rbf', 'white'});
optionsDyn.kern.comp{1}.inverseWidth = 0.2;
% This gives signal to noise of 0.1:5e-3 or 20:1.
optionsDyn.kern.comp{1}.variance = 0.01;
optionsDyn.kern.comp{2}.variance = 0.95;
diff = 1;
learn = 1;
optionsDyn.fixIndices = round(linspace(1, size(Y, 1)-length(seq), options.numActive));
model = fgplvmAddDynamics(model, 'gp', optionsDyn, diff, learn, seq);

% Optimise the model.
iters = 1000;
display = 1;

model = fgplvmOptimise(model, display, iters);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

