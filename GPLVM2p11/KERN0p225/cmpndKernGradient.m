function g = cmpndKernGradient(kern, x, varargin)

% CMPNDKERNGRADIENT Gradient of CMPND kernel's parameters.
%
%	Description:
%
%	G = CMPNDKERNGRADIENT(KERN, X, PARTIAL) computes the gradient of
%	functions with respect to the compound kernel's parameters. As well
%	as the kernel structure and the input positions, the user provides a
%	matrix PARTIAL which gives the partial derivatives of the function
%	with respect to the relevant elements of the kernel matrix.
%	 Returns:
%	  G - gradients of the function of interest with respect to the
%	   kernel parameters. The ordering of the vector should match that
%	   provided by the function kernExtractParam.
%	 Arguments:
%	  KERN - the kernel structure for which the gradients are being
%	   computed.
%	  X - the input locations for which the gradients are being
%	   computed.
%	  PARTIAL - matrix of partial derivatives of the function of
%	   interest with respect to the kernel matrix. The argument takes the
%	   form of a square matrix of dimension  numData, where numData is
%	   the number of rows in X.
%
%	G = CMPNDKERNGRADIENT(KERN, X1, X2, PARTIAL) computes the
%	derivatives as above, but input locations are now provided in two
%	matrices associated with rows and columns of the kernel matrix.
%	 Returns:
%	  G - gradients of the function of interest with respect to the
%	   kernel parameters.
%	 Arguments:
%	  KERN - the kernel structure for which the gradients are being
%	   computed.
%	  X1 - the input locations associated with the rows of the kernel
%	   matrix.
%	  X2 - the input locations associated with the columns of the kernel
%	   matrix.
%	  PARTIAL - matrix of partial derivatives of the function of
%	   interest with respect to the kernel matrix. The matrix should have
%	   the same number of rows as X1 and the same number of columns as X2
%	   has rows.
%	
%
%	See also
%	% SEEALSO CMPNDKERNPARAMINIT, KERNGRADIENT, CMPNDKERNDIAGGRADIENT, KERNGRADX


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	cmpndKernGradient.m CVS version 1.8
% 	cmpndKernGradient.m SVN version 355
% 	last update 2009-05-14T11:55:31.000000Z


g = zeros(1, size(kern.paramGroups, 1));
startVal = 1;
endVal = 0;

for i = 1:length(kern.comp)
  endVal = endVal + kern.comp{i}.nParams;
  if ~isempty(kern.comp{i}.index)
    % only part of the data is involved in the kernel.
    if nargin < 4
      g(1, startVal:endVal)  = kernGradient(kern.comp{i}, ...
                                            x(:, kern.comp{i}.index), ...
                                            varargin{:});
    else
      g(1, startVal:endVal) = kernGradient(kern.comp{i}, ...
                                            x(:, kern.comp{i}.index), ...
                                           varargin{1}(:, kern.comp{i}.index), ...
                                           varargin{2:end});
    end
  else
    % all the data is involved with the kernel.
    g(1, startVal:endVal)  = kernGradient(kern.comp{i}, x, varargin{:});
  end
  startVal = endVal + 1;
end
g = g*kern.paramGroups;
