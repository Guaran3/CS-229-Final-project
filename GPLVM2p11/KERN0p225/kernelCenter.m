function Kc = kernelCenter(K)

% KERNELCENTER Attempts to Center Kernel Matrix
%
%	Description:
%
%	KC = KERNELCENTER(MATRIX) returns a centered kernel matrix
%	 Returns:
%	  KC - The centered kernel
%	 Arguments:
%	  MATRIX - % ARG kernel matrix
%	
%
%	See also
%	


%	Copyright (c) 2008 Carl Henrik Ek
% 	kernelCenter.m SVN version 105
% 	last update 2008-10-11T19:45:34.000000Z

if(nargin<1)
  error('To Few Arguments');
end
if(size(K,1)~=size(K,2))
  error('Kernel Not Square');
end

Kc = (eye(size(K)) - 1/size(K,1)*ones(size(K)))*K*(eye(size(K))-1/size(K,1)*ones(size(K)));

return;