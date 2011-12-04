function gplvmResultsCpp(fileName, dataType, varargin)

% GPLVMRESULTSCPP Load a results file and visualise them.
%
%	Description:
%	gplvmResultsCpp(fileName, dataType, varargin)
%% 	gplvmResultsCpp.m CVS version 1.2
% 	gplvmResultsCpp.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z
  
[model, lbls] = gplvmReadFromFile(fileName);
% Visualise the results
switch size(model.X, 2) 
 case 1
  gplvmVisualise1D(model, [dataType 'Visualise'], [dataType 'Modify'], ...
		   varargin{:});
  
 case 2
  gplvmVisualise(model, lbls, [dataType 'Visualise'], [dataType 'Modify'], ...
                 varargin{:});
  
 otherwise 
  error('No visualisation code for data of this latent dimension.');
end