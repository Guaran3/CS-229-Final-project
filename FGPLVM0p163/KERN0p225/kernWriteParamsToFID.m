function kernWriteParamsToFID(kern, FID)

% KERNWRITEPARAMSTOFID Write the kernel parameters to a stream.
%
%	Description:
%
%	KERNWRITEPARAMSTOFID(KERN, FID) writes kernel parameters to a
%	stream.
%	 Arguments:
%	  KERN - the kernel that the parameters are in.
%	  FID - the stream to which parameters are written.
%	
%
%	See also
%	KERNWRITETOFID, MODELWRITETOFID


%	Copyright (c) 2005, 2006, 2008 Neil D. Lawrence
% 	kernWriteParamsToFID.m SVN version 20
% 	last update 2008-10-11T19:45:36.000000Z

if strcmp(kern.type, 'cmpnd') || strcmp(kern.type, 'tensor')
  componentKernWriteParamsToFID(kern, FID);
else
  writeIntToFID(FID, 'inputDim', kern.inputDimension);
  writeIntToFID(FID, 'numParams', kern.nParams);
  
  if strcmp(kern.type, 'poly') | strcmp(kern.type, 'polyard')
    writeIntToFID(FID, 'numParams', kern.degree);
  end
  
  fhandle = str2func([kern.type 'KernExtractParam']);
  params = fhandle(kern);
  doubleMatrixWriteToFID(params, FID);
  if isfield(kern, 'priors')
    writeIntToFID(FID, 'numPriors', length(kern.priors));
    for j=1:length(kern.priors)
      writeIntToFID(FID, 'priorIndex', kern.priors(j).index);
      priorWriteToFID(FID, prior);
    end
  else
    writeIntToFID(FID, 'numPriors', 0);
  end
end

