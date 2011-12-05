function k = ouKernDiagCompute(kern, t)

% OUKERNDIAGCOMPUTE Compute diagonal of OU kernel (see ouKernCompute or
%
%	Description:
%	ouKernParamInit for a more detailed description of the OU kernel).
%
%	K = OUKERNDIAGCOMPUTE(KERN, T) computes the diagonal of the kernel
%	matrix for the OU (Ornstein - Uhlenbeck kernel given a column vector
%	of inputs. So far the dimension of the inputs has to be one.
%	 Returns:
%	  K - a vector of the same size as t containing the diagonal of the
%	   kernel matrix computed at the given points.
%	 Arguments:
%	  KERN - the kernel structure for which the kernel matrix is
%	   computed.
%	  T - input data in the form of a column vector.
%	
%
%	See also
%	OUKERNPARAMINIT, KERNDIAGCOMPUTE, KERNCREATE, OUKERNCOMPUTE


%	Copyright (c) 2009 David Luengo
% 	ouKernDiagCompute.m SVN version 195
% 	last update 2009-01-23T17:54:58.000000Z


if size(t, 2) > 1
  error('Input can only have one column');
end

c = 0.5*kern.variance/kern.decay;
k = ones(size(t,1), 1);
if (kern.isStationary == false)
    k = k - exp(-2*kern.decay*t);
end
k = c*k;
