function kern = fileKernParamInit(kern)

% FILEKERNPARAMINIT FILE kernel parameter initialisation.
%
%	Description:
%	The file (FILE) kernel is designed for working with pre-computed
%	kernel files that are saved on disk. It loads in a file the
%	first time it is accessed and then caches it in memory (in single
%	precision). The cacheing is done in by the fileKernRead command.
%	
%	This kernel type was originally written for working with Bill
%	Stafford Noble's yeast data, available at
%	http://noble.gs.washington.edu/proj/yeast/
%	
%	
%
%	KERN = FILEKERNPARAMINIT(KERN) initialises the stored file kernel
%	structure with some default parameters.
%	 Returns:
%	  KERN - the kernel structure with the default parameters placed in.
%	 Arguments:
%	  KERN - the kernel structure which requires initialisation.
%	
%
%	See also
%	FILEKERNREAD, KERNCREATE, KERNPARAMINIT


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	fileKernParamInit.m CVS version 1.3
% 	fileKernParamInit.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


kern.variance = 1;
kern.nParams = 1;

kern.transforms.index = [1];
kern.transforms.type = optimiDefaultConstraint('positive');

kern.isStationary = false;