function fileName = dnetWriteResult(model, dataSet, number)

% DNETWRITERESULT Write a DNET result.
%
%	Description:
%
%	FILENAME = DNETWRITERESULT(MODEL, DATASET, NUMBER) writes a DNET
%	result.
%	 Returns:
%	  FILENAME - the file name used to write.
%	 Arguments:
%	  MODEL - the model to write.
%	  DATASET - the name of the data set to write.
%	  NUMBER - the number of the DNET run to write.
%	
%
%	See also
%	DNETLOADRESULT


%	Copyright (c) 2009 Neil D. Lawrence
% 	dnetWriteResult.m SVN version 545
% 	last update 2009-10-06T11:16:44.000000Z

dataSet(1) = upper(dataSet(1));
type = model.type;
type(1) = upper(type(1));
fileName = ['dem' dataSet type num2str(number)];

[mapping, dnetInfo] = dnetDeconstruct(model);

save(fileName, 'mapping', 'dnetInfo');