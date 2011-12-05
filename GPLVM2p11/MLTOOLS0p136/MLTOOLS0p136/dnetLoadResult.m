function [model, lbls] = dnetLoadResult(dataSet, number)

% DNETLOADRESULT Load a previously saved result.
%
%	Description:
%
%	MODEL = DNETLOADRESULT(DATASET, NUMBER) loads a previously saved
%	DNET result.
%	 Returns:
%	  MODEL - the saved model.
%	 Arguments:
%	  DATASET - the name of the data set to load.
%	  NUMBER - the number of the DNET run to load.
%	
%
%	See also
%	DNETLOADRESULT


%	Copyright (c) 2009 Neil D. Lawrence
% 	dnetLoadResult.m SVN version 536
% 	last update 2009-09-30T15:10:27.000000Z

  [Y, lbls] = lvmLoadData(dataSet);

  dataSet(1) = upper(dataSet(1));
  load(['dem' dataSet 'Dnet' num2str(number)])
  model = dnetReconstruct(mapping, dnetInfo, Y);
end