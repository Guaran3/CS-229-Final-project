function k = tensorKernDiagCompute(kern, x)

% TENSORKERNDIAGCOMPUTE Compute diagonal of TENSOR kernel.
%
%	Description:
%
%	K = TENSORKERNDIAGCOMPUTE(KERN, X) computes the diagonal of the
%	kernel matrix for the tensor product kernel given a design matrix of
%	inputs.
%	 Returns:
%	  K - a vector containing the diagonal of the kernel matrix computed
%	   at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the matrix is computed.
%	  X - input data matrix in the form of a design matrix.
%	
%
%	See also
%	TENSORKERNPARAMINIT, KERNDIAGCOMPUTE, KERNCREATE, TENSORKERNCOMPUTE


%	Copyright (c) 2006 Neil D. Lawrence
% 	tensorKernDiagCompute.m CVS version 1.3
% 	tensorKernDiagCompute.m SVN version 1
% 	last update 2006-10-25T10:53:01.000000Z


i = 1;
if ~isempty(kern.comp{i}.index)
  % only part of the data is involved with the kernel.
  k  = kernDiagCompute(kern.comp{i}, x(:, kern.comp{i}.index));
else
  % all the data is involved with the kernel.
  k  = kernDiagCompute(kern.comp{i}, x);
end
for i = 2:length(kern.comp)
  if ~isempty(kern.comp{i}.index)
    % only part of the data is involved with the kernel.
    k  = k.*kernDiagCompute(kern.comp{i}, x(:, kern.comp{i}.index));
  else
    % all the data is involved with the kernel.
    k  = k.*kernDiagCompute(kern.comp{i}, x);
  end
end
