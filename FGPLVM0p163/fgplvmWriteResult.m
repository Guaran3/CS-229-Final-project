function fileName = fgplvmWriteResult(model, dataSet, number)

% FGPLVMWRITERESULT Write a FGPLVM result.
%
%	Description:
%
%	FILENAME = FGPLVMWRITERESULT(MODEL, DATASET, NUMBER) writess an
%	FGPLVM result.
%	 Returns:
%	  FILENAME - the file name used to write.
%	 Arguments:
%	  MODEL - the model to write.
%	  DATASET - the name of the data set to write.
%	  NUMBER - the number of the FGPLVM run to write.
%	
%
%	See also
%	FGPLVMLOADRESULT


%	Copyright (c) 2009 Neil D. Lawrence
% 	fgplvmWriteResult.m SVN version 545
% 	last update 2009-10-07T13:42:52.000000Z

[Y, lbls] = lvmLoadData(dataSet);

dataSet(1) = upper(dataSet(1));
type = model.type;
type(1) = upper(type(1));
fileName = ['dem' dataSet type num2str(number)];

[kern, noise, fgplvmInfo, X] = fgplvmDeconstruct(model);

save(fileName, 'kern', 'noise', 'fgplvmInfo', 'X');