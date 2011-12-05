
% DEMSILHOUETTELINEAR1 Model silhouette data with independent linear models.
%
%	Description:
%	% 	demSilhouetteLinear1.m SVN version 327
% 	last update 2008-12-02T10:26:57.000000Z
% FORMAT
% DESC runs a simple regression on the Agawal and Triggs data.
%
% SEEALSO : demSilhouetteGp1, demSilhouetteAverage
% 
% COPYRIGHT : Neil D. Lawrence, 2008


randn('seed', 1e7)
rand('seed', 1e7)

dataSetName = 'silhouette';
experimentNo = 1;

% load data
[X, y, XTest, yTest] = mapLoadData(dataSetName);


% Set up the model
options = linearOptions;

q = size(X, 2);
d = size(y, 2);
model = linearCreate(q, d, options);


model = linearOptimise(model, X, y);
modelDisplay(model)

% Save results
capName = dataSetName;;
capName(1) = upper(capName(1));
fileBaseName = ['dem' capName 'Linear' num2str(experimentNo)];
save([fileBaseName '.mat'], 'model');


demSilhouettePlot