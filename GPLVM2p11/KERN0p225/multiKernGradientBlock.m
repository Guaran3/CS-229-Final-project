function [g1, g2] = multiKernGradientBlock(kern, X, X2, covGrad, i, j)

% MULTIKERNGRADIENTBLOCK
%
%	Description:
%
%	[G1, G2] = MULTIKERNGRADIENTBLOCK(KERN, X1, X2, COVGRAD, I, J)
%	computes the gradient with respect to parameters for a block of a
%	multi-output kernel given two matrices of input.
%	 Returns:
%	  G1 - the gradient of the kernel parameters from the first kernel
%	   in the order provided by the relevant kernExtractParam commands.
%	  G2 - the gradient of the kernel parameters from the second kernel
%	   in the order provided by the relevant kernExtractParam commands.
%	 Arguments:
%	  KERN - the structure containing the kernel.
%	  X1 - first set of kernel inputs.
%	  X2 - second set of kernel inputs.
%	  COVGRAD - Gradient of the objective function with respect to the
%	   relevant portion of the kernel matrix.
%	  I - the row of the block of the kernel to be computed.
%	  J - the column of the block of the kernel to be computed.
%
%	[G1, G2] = MULTIKERNGRADIENTBLOCK(KERN, X, COVGRAD, I, J) compute a
%	block of a multi-output kernel given a single matrix of input.
%	 Returns:
%	  G1 - the gradient of the kernel parameters from the first kernel
%	   in the order provided by the relevant kernExtractParam commands.
%	  G2 - the gradient of the kernel parameters from the second kernel
%	   in the order provided by the relevant kernExtractParam commands.
%	 Arguments:
%	  KERN - the structure containing the kernel.
%	  X - first set of kernel inputs.
%	  COVGRAD - Gradient of the objective function with respect to the
%	   relevant portion of the kernel matrix.
%	  I - the row of the block of the kernel to be computed.
%	  J - the column of the block of the kernel to be computed.
%	
%
%	See also
%	MULTIKERNCREATE, MULTIKERNGRADIENT, MULTIKERNCOMPUTEBLOCK


%	Copyright (c) 2006 Neil D. Lawrence
% 	multiKernGradientBlock.m CVS version 1.1
% 	multiKernGradientBlock.m SVN version 262
% 	last update 2009-02-27T11:16:05.000000Z

if nargin < 6
  j = i;
  i = covGrad;
  covGrad = X2;
  X2 = [];
end  

% There is no gradient with respect to fixed blocks.
if isfield(kern, 'fixedBlocks') && kern.fixedBlocks(i) && ...
      kern.fixedBlocks(j),
  g1 = 0;
  g2 = 0;
  return;
end

outArg = 2;
if i == j
  fhandle = [kern.comp{i}.type 'KernGradient'];
  transpose = 0;
  arg{1} = kern.comp{i};
  factors = kernFactors(kern.comp{i}, 'gradfact');
  outArg = 1;
else
  if j<i
    fhandle = [kern.block{i}.cross{j} 'KernGradient'];
    transpose = kern.block{i}.transpose(j);
  else
    fhandle = [kern.block{j}.cross{i} 'KernGradient'];
    transpose = ~kern.block{j}.transpose(i);
  end
  if transpose
    arg{1} = kern.comp{j};
    factors{1} = kernFactors(kern.comp{j}, 'gradfact');
    arg{2} = kern.comp{i};
    factors{2} = kernFactors(kern.comp{i}, 'gradfact');
  else
    arg{1} = kern.comp{i};
    factors{1} = kernFactors(kern.comp{i}, 'gradfact');
    arg{2} = kern.comp{j};
    factors{2} = kernFactors(kern.comp{j}, 'gradfact');
  end
end
fhandle = str2func(fhandle);
arg{end+1} = X;
if ~isempty(X2);
  arg{end+1} = X2;
end
switch outArg
 case 1
  g1 = fhandle(arg{:}, covGrad);
  g1(factors.index) = g1(factors.index).*factors.val;

 case 2 
  [g1, g2] = fhandle(arg{:}, covGrad);
  g1(factors{1}.index) = g1(factors{1}.index).*factors{1}.val;
  g2(factors{2}.index) = g2(factors{2}.index).*factors{2}.val;

  if transpose
    g = g2;
    g2 = g1;
    g1 = g;
  end
 otherwise 
  error('Invalid number of out arguments.')
end