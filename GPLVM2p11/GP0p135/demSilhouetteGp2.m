
% DEMSILHOUETTEGP2 Model silhouette data with independent MLP GPs.
%
%	Description:
%	% 	demSilhouetteGp2.m SVN version 536
% 	last update 2009-09-29T13:48:36.000000Z
% FORMAT
% DESC runs a simple regression on the Agawal and Triggs data.
%
% SEEALSO : gpCreate, demInterpolation
% 
% COPYRIGHT : Neil D. Lawrence, 2008


randn('seed', 1e7)
rand('seed', 1e7)

dataSetName = 'silhouette';
experimentNo = 2;

% load data
[X, y, XTest, yTest] = mapLoadData(dataSetName);

% Set up the model
options = gpOptions('ftc');
options.kern{1} = 'mlp';

% Scale outputs to variance 1.
options.scale2var1 = true;

% Use the full Gaussian process model.
q = size(X, 2);
d = size(y, 2);
model = gpCreate(q, d, X, y, options);

display = 1;
iters = 1000;

model = gpOptimise(model, display, iters);
modelDisplay(model)

% Save results
fileBaseName = modelWriteResult(dataSetName, experimentNo);
demSilhouettePlot
