function fgplvmResultsCpp(fileName, dataType, varargin)

% FGPLVMRESULTSCPP Load a results file and visualise them.
%
%	Description:
%
%	FGPLVMRESULTSCPP(FILENAME, DATATYPE, ...) loads a model stored in
%	the file name and visualizes results with it.
%	 Arguments:
%	  FILENAME - file name of the stored model.
%	  DATATYPE - type of visualization to perform.
%	  ... - additional options to pass to the visualization.
%	
%
%	See also
%	% SEEALSO GPLVMRESULTSCPP, LVMVISUALISE


%	Copyright (c) 2009 Neil D. Lawrence
% 	fgplvmResultsCpp.m SVN version 544
% 	last update 2009-10-02T09:23:33.000000Z
  
[model, lbls] = fgplvmReadFromFile(fileName);

lvmVisualise(model, lbls, [dataType 'Visualise'], [dataType 'Modify'], ...
             varargin{:});
