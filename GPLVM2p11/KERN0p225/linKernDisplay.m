function linKernDisplay(kern, spacing)

% LINKERNDISPLAY Display parameters of the LIN kernel.
%
%	Description:
%
%	LINKERNDISPLAY(KERN) displays the parameters of the linear kernel
%	and the kernel type to the console.
%	 Arguments:
%	  KERN - the kernel to display.
%
%	LINKERNDISPLAY(KERN, SPACING)
%	 Arguments:
%	  KERN - the kernel to display.
%	  SPACING - how many spaces to indent the display of the kernel by.
%	
%
%	See also
%	LINKERNPARAMINIT, MODELDISPLAY, KERNDISPLAY


%	Copyright (c) 2004, 2005, 2006 Neil D. Lawrence
% 	linKernDisplay.m CVS version 1.5
% 	linKernDisplay.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z


if nargin > 1
  spacing = repmat(32, 1, spacing);
else
  spacing = [];
end
spacing = char(spacing);
fprintf(spacing)
fprintf('Linear kernel Variance: %2.4f\n', kern.variance)
