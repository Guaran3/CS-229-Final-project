function whitefixedKernDisplay(kern, spacing)

% WHITEFIXEDKERNDISPLAY Display parameters of the WHITEFIXED kernel.
%
%	Description:
%
%	WHITEFIXEDKERNDISPLAY(KERN) displays the parameters of the fixed
%	parameter white noise kernel and the kernel type to the console.
%	 Arguments:
%	  KERN - the kernel to display.
%
%	WHITEFIXEDKERNDISPLAY(KERN, SPACING)
%	 Arguments:
%	  KERN - the kernel to display.
%	  SPACING - how many spaces to indent the display of the kernel by.
%	
%
%	See also
%	WHITEFIXEDKERNPARAMINIT, MODELDISPLAY, KERNDISPLAY


%	Copyright (c) 2006 Nathaniel J. King
% 	whitefixedKernDisplay.m CVS version 1.5
% 	whitefixedKernDisplay.m SVN version 151
% 	last update 2008-11-06T10:11:56.000000Z

if nargin > 1
  spacing = repmat(32, 1, spacing);
else
  spacing = [];
end
spacing = char(spacing);
fprintf(spacing);
fprintf('White Fixed Noise Variance: %2.4f\n', kern.variance)
