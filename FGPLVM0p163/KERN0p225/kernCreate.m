function kern = kernCreate(X, kernelType)

% KERNCREATE Initialise a kernel structure.
%
%	Description:
%
%	KERN = KERNCREATE(X, TYPE) creates a kernel matrix structure given
%	an design matrix of input points and a kernel type.
%	 Returns:
%	  KERN - The kernel structure.
%	 Arguments:
%	  X - Input data values (from which kernel will later be computed).
%	  TYPE - Type of kernel to be created, some standard types are
%	   'lin', 'rbf', 'white', 'bias' and 'rbfard'. If a cell of the form
%	   {'cmpnd', 'rbf', 'lin', 'white'} is used a compound kernel based
%	   on the sum of the individual kernels will be created. The 'cmpnd'
%	   element at the start of the sequence is optional. Furthermore,
%	   {'tensor', 'rbf', 'lin'} can be used to give a tensor product
%	   kernel, whose elements are the formed from the products of the two
%	   indvidual kernel's elements and finally {'multi', 'rbf', ...} can
%	   be used to create a block structured kernel for use with multiple
%	   outputs.
%
%	KERN = KERNCREATE(DIM, TYPE) creates a kernel matrix structure given
%	the dimensions of the design matrix and the kernel type.
%	 Returns:
%	  KERN - The kernel structure.
%	 Arguments:
%	  DIM - input dimension of the design matrix (i.e. number of
%	   features in the design matrix).
%	  TYPE - Type of kernel to be created, as described above.
%
%	See also
%	KERNPARAMINIT
% 	kernCreate.m CVS version 1.9
% 	kernCreate.m SVN version 263
% 	last update 2009-02-27T11:16:04.000000Z
  
if iscell(X)  
  for i = 1:length(X)
    dim(i) = size(X{i}, 2);
  end
else
  % This is a bit of a hack to allow the creation of a kernel without
  % providing an input data matrix (which is sometimes useful). If the X
  % structure is a 1x1 it is assumed that it is the dimension of the
  % input data.
  dim = size(X, 2);
  if dim == 1 & size(X, 1) == 1;
    dim = X;
  end
end

if iscell(kernelType)
  kern.inputDimension = dim;
  switch kernelType{1}
   case 'multi'
    % multi output block based kernel.
    start = 2;
    kern.type = 'multi';
   case 'tensor'
    % tensor kernel type
    start = 2;
    kern.type = 'tensor';
   case 'cmpnd'
    % compound kernel type
    start = 2;
    kern.type = 'cmpnd';
   case 'translate'
    % translate kernel type
    start = 2;
    kern.type = 'translate';
   case 'exp'
    % exponentiated kernel type
    start = 2;
    kern.type = 'exp';
   otherwise
    % compound kernel type
    start = 1;
    kern.type = 'cmpnd';
  end
  switch kern.type
   case 'multi'
    for i = start:length(kernelType)
      if iscell(X)
        kern.comp{i-start+1} = kernCreate(X{i-start+1}, kernelType{i});
        kern.diagBlockDim{i-start+1} = length(X{i-start+1});
      else
        kern.comp{i-start+1} = kernCreate(X, kernelType{i});
      end
      kern.comp{i-start+1}.index = [];
    end
   case {'tensor', 'cmpnd', 'translate'}
    for i = start:length(kernelType)
      kern.comp{i-start+1} = kernCreate(X, kernelType{i});
      kern.comp{i-start+1}.index = [];
    end    
   case 'exp'
    if start == length(kernelType)
      kern.argument = kernCreate(X, kernelType{start});
    else
      kern.argument = kernCreate(X, kernelType(start:end));
    end
  end
  kern = kernParamInit(kern);
elseif isstruct(kernelType)
  % If a structure is passed, use it as the kernel.
  kern = kernelType;
else
  kern.type = kernelType;
  if iscell(X)
    kern.inputDimension = dim(i);
  else
    kern.inputDimension = dim;
  end
  kern = kernParamInit(kern);
end
kern.Kstore = [];
kern.diagK = [];
