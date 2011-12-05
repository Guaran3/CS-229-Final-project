
% DEMSPGP1DGP2 Do a simple 1-D regression after Snelson & Ghahramani's example.
%
%	Description:
%	% 	demSpgp1dGp2.m SVN version 536
% 	last update 2009-09-29T13:26:07.000000Z

% Fix seeds
randn('seed', 2e5);
rand('seed', 2e5);
seedVal = 2e5;
dataSetName = 'spgp1d';
experimentNo = 2;

% load data
[X, y] = mapLoadData(dataSetName, seedVal);

% Set up model
options = gpOptions('fitc');
options.numActive = 9;
options.optimiser = 'conjgrad';

% use the deterministic training conditional.
q = size(X, 2);
d = size(y, 2);

model = gpCreate(q, d, X, y, options);
model.X_u = randn(9, 1)*0.25 - 0.75;
params = gpExtractParam(model);
model = gpExpandParam(model, params);

% Optimise the model.
iters = 1000;
display = 1;
model.beta = 4/var(y);
model.kern.variance = var(y);
model.kern.inverseWidth = 1./((-min(X)+max(X))'/2).^2

model = gpOptimise(model, display, iters);

% Save the results.
fileName = modelWriteResult(model, dataSetName, experimentNo);

demSpgp1dPlot
