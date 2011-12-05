
% DEMSPGP1DGP5 Do a simple 1-D regression after Snelson & Ghahramani's example.
%
%	Description:
%	% 	demSpgp1dGp5.m SVN version 545
% 	last update 2009-09-29T13:23:51.000000Z

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'spgp1d';
experimentNo = 5;

% load data
[X, y] = mapLoadData(dataSetName);

% Set up model
options = gpOptions('dtcvar');
options.kern = {'rbf', 'bias', 'white'}
options.numActive = 9;
options.optimiser = 'scg';

% use the deterministic training conditional.
q = size(X, 2);
d = size(y, 2);

model = gpCreate(q, d, X, y, options);
model.kern.comp{3}.variance = 1e-4;
model.X_u = randn(options.numActive, 1)*0.1;
params = gpExtractParam(model);
model = gpExpandParam(model, params);

% Optimise the model.
iters = 1000;
display = 1;

model = gpOptimise(model, display, iters);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);


demSpgp1dPlot
