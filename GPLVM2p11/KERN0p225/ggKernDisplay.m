function ggKernDisplay(kern, spacing)

% GGKERNDISPLAY Display parameters of the GG kernel.
%
%	Description:
%
%	GGKERNDISPLAY(KERN) displays the parameters of the radial basis
%	function kernel and the kernel type to the console.
%	 Arguments:
%	  KERN - the kernel to display.
%
%	GGKERNDISPLAY(KERN, SPACING)
%	 Arguments:
%	  KERN - the kernel to display.
%	  SPACING - how many spaces to indent the display of the kernel by.
%	
%
%	See also
%	GGKERNPARAMINIT, MODELDISPLAY, KERNDISPLAY


%	Copyright (c) 2004, 2005, 2006, 2008 Neil D. Lawrence
% 	ggKernDisplay.m SVN version 426
% 	last update 2009-07-17T10:58:29.000000Z

if nargin > 1
  spacing = repmat(32, 1, spacing);
else
  spacing = [];
end
spacing = char(spacing);
for k=1:size(kern.precisionU,1),
    fprintf(spacing);
    fprintf('GAUSSIAN inverse width %5d: %2.4f (length scale %2.4f)\n', ...
            k, kern.precisionU(k), 1/sqrt(kern.precisionU(k)));
end
for k=1:size(kern.precisionG,1),
    fprintf(spacing);
    fprintf('GG inverse width %5d: %2.4f (length scale %2.4f)\n', ...
            k, kern.precisionG(k), 1/sqrt(kern.precisionG(k)));    
end
fprintf(spacing);    
fprintf('GAUSSIAN variance: %2.4f\n', kern.sigma2Latent)
fprintf(spacing);
fprintf('GG sensitivity: %2.4f\n', kern.sensitivity)
