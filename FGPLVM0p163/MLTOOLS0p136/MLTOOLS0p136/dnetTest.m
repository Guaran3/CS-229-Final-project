
% DNETTEST Test some settings for the density network.
%
%	Description:
%	% 	dnetTest.m SVN version 24
% 	last update 2008-06-16T14:34:19.000000Z

model = dnetCreate(2, 3, randn(2, 3), dnetOptions);

model.basisStored = false;

modelTest(model)  