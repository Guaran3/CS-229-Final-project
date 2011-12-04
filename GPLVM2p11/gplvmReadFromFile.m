function [model,labels] = gplvmReadFromFile(fileName)

% GPLVMREADFROMFILE Load a file produced by the c++ implementation.
%
%	Description:
%	[model,labels] = gplvmReadFromFile(fileName)
%% 	gplvmReadFromFile.m CVS version 1.1
% 	gplvmReadFromFile.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

FID = fopen(fileName);
if FID==-1
  error(['Cannot find file ' fileName])
end
[model, labels] = gplvmReadFromFID(FID);
fclose(FID);