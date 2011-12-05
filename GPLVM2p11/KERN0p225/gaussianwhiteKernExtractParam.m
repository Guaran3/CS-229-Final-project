function [params, names] = gaussianwhiteKernExtractParam(kern)

% GAUSSIANWHITEKERNEXTRACTPARAM Extract parameters from the gaussian white
%
%	Description:
%	kernel structure.
%
%	PARAM = GAUSSIANWHITEKERNEXTRACTPARAM(KERN) extracts parameters from
%	the gaussian white kernel structure into a vector of parameters for
%	optimisation.
%	 Returns:
%	  PARAM - vector of parameters extracted from the kernel. If the
%	   field 'transforms' is not empty in the kernel matrix, the
%	   parameters will be transformed before optimisation (for example
%	   positive only parameters could be logged before being returned).
%	 Arguments:
%	  KERN - the kernel structure containing the parameters to be
%	   extracted.
%	DESC extracts parameters and
%	parameter names from the gaussian white kernel structure.
%	RETURN param :vector of parameters extracted from the kernel. If the
%	field 'transforms' is not empty in the kernel matrix, the
%	parameters will be transformed before optimisation (for example
%	positive only parameters could be logged before being returned).
%	RETURN names : cell array of strings giving names to the parameters.
%	ARG kern : the kernel structure containing the parameters to be
%	extracted.
%	
%	kernExtractParam, scg, conjgrad
%	
%	
%
%	See also
%	GAUSSIANWHITEKERNPARAMINIT, GAUSSIANWHITEKERNEXPANDPARAM, 


%	Copyright (c) 2008 Mauricio A. Alvarez and Neil D. Lawrence


%	With modifications by Mauricio A. Alvarez 2009.
% 	gaussianwhiteKernExtractParam.m SVN version 430
% 	last update 2009-08-10T17:13:12.000000Z

if kern.isArd
    if kern.nIndFunct == 1,
        params = kern.precisionT';
    else
        params = kern.precisionT(:)';
    end
else
    params = kern.precisionT;
end
params(end+1) = kern.sigma2Noise;
unames = cell(1,numel(kern.precisionT));
if nargout > 1
    cont = 0;
    if exist([kern.type 'Names.txt'], 'file')
        fidNames = fopen([kern.type 'Names.txt'],'r');
        for j=1:size(kern.precisionT,1),
            cont = cont + 1;
            unames{cont} = fgetl(fidNames);
        end
        fclose(fidNames);
    else        
        for i=1:size(kern.precisionT,2)
            for j=1:size(kern.precisionT,1)
                cont = cont + 1;
                unames{cont}=['VIK ' num2str(i) ', inverse width ' num2str(j) '.'];                
            end
        end                            
    end
    names = unames(:);
    names = {names{:}, 'variance latent'};
end