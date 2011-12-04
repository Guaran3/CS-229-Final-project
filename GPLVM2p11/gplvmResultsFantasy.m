function gplvmResultsFantasy(dataset, number, dataType, varargin)

% GPLVMRESULTSFANTASY Load a results file and visualise the `fantasies'.
%
%	Description:
%	gplvmResultsFantasy(dataset, number, dataType, varargin)
%% 	gplvmResultsFantasy.m CVS version 1.6
% 	gplvmResultsFantasy.m SVN version 326
% 	last update 2009-04-17T21:36:39.000000Z

[Y, lbls] = lvmLoadData(dataset);

dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

% Visualise the results
if size(model.X, 2) ==1 
  error('not yet implemented fantasy 1-D visualisation')

elseif size(model.X, 2) == 2
  gplvmFantasyPlot(model, [dataType 'Visualise'], 0.05, 1.5, varargin{:});
else
  error('no visualisation code for data of of this latent dimension');
end