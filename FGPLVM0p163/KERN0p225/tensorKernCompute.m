function k = tensorKernCompute(kern, x, x2)

% TENSORKERNCOMPUTE Compute the TENSOR kernel given the parameters and X.
%
%	Description:
%
%	K = TENSORKERNCOMPUTE(KERN, X, X2) computes the kernel parameters
%	for the tensor product kernel given inputs associated with rows and
%	columns.
%	 Returns:
%	  K - the kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  X - the input matrix associated with the rows of the kernel.
%	  X2 - the input matrix associated with the columns of the kernel.
%
%	K = TENSORKERNCOMPUTE(KERN, X) computes the kernel matrix for the
%	tensor product kernel given a design matrix of inputs.
%	 Returns:
%	  K - the kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  X - input data matrix in the form of a design matrix.
%	
%
%	See also
%	TENSORKERNPARAMINIT, KERNCOMPUTE, KERNCREATE, TENSORKERNDIAGCOMPUTE


%	Copyright (c) 2006 Neil D. Lawrence
% 	tensorKernCompute.m CVS version 1.3
% 	tensorKernCompute.m SVN version 1
% 	last update 2006-10-25T10:53:01.000000Z


if nargin > 2
  i = 1;
  if ~isempty(kern.comp{i}.index)
    % only part of the data is involved in the kernel.
    k = kernCompute(kern.comp{i}, ...
                         x(:, kern.comp{i}.index), ...
                         x2(:, kern.comp{i}.index));
  else
    % all the data is involved with the kernel.
    k = kernCompute(kern.comp{i}, x, x2);
  end
  for i = 2:length(kern.comp)
    if ~isempty(kern.comp{i}.index)
      % only part of the data is involved in the kernel.
      k  = k.*kernCompute(kern.comp{i}, ...
                          x(:, kern.comp{i}.index), ...
                          x2(:, kern.comp{i}.index));
    else
      % all the data is involved with the kernel.
      k  = k.*kernCompute(kern.comp{i}, x, x2);
    end
  end
else
  i = 1;
  if ~isempty(kern.comp{i}.index)
    % only part of the data is involved with the kernel.
    k  = kernCompute(kern.comp{i}, x(:, kern.comp{i}.index));
  else
    % all the data is involved with the kernel.
    k  = kernCompute(kern.comp{i}, x);
  end
  for i = 2:length(kern.comp)
    if ~isempty(kern.comp{i}.index)
      % only part of the data is involved with the kernel.
      k  = k.*kernCompute(kern.comp{i}, x(:, kern.comp{i}.index));
    else
      % all the data is involved with the kernel.
      k  = k.*kernCompute(kern.comp{i}, x);
    end
  end
end
