function lfmKernDisplay(kern, spacing)

% LFMKERNDISPLAY Display parameters of the LFM kernel.
%
%	Description:
%
%	LFMKERNDISPLAY(KERN) displays the parameters of the single input
%	motif kernel and the kernel type to the console.
%	 Arguments:
%	  KERN - the kernel to display.
%
%	LFMKERNDISPLAY(KERN, SPACING)
%	 Arguments:
%	  KERN - the kernel to display.
%	  SPACING - how many spaces to indent the display of the kernel by.
%	
%
%	See also
%	LFMKERNPARAMINIT, MODELDISPLAY, KERNDISPLAY


%	Copyright (c) 2006 Neil D. Lawrence
% 	lfmKernDisplay.m SVN version 133
% 	last update 2008-10-28T12:52:43.000000Z

if nargin > 1
  spacing = repmat(32, 1, spacing);
else
  spacing = [];
end
spacing = char(spacing);
fprintf(spacing);
fprintf('LFM Latent variance: %2.4f\n', kern.variance)
fprintf(spacing);
fprintf('LFM inverse width: %2.4f (length scale %2.4f)\n', ...
        kern.inverseWidth, 1/sqrt(kern.inverseWidth));
%fprintf(spacing);
%fprintf('LFM delay: %2.4f\n', kern.delay)
fprintf(spacing);
fprintf('LFM sensitivity: %2.4f\n', kern.sensitivity)
fprintf(spacing);
fprintf('LFM mass: %2.4f\n', kern.mass)
fprintf(spacing);
fprintf('LFM spring: %2.4f\n', kern.spring)
fprintf(spacing);
fprintf('LFM damper: %2.4f\n', kern.damper)
fprintf(spacing);
fprintf('System Characteristics:\n')
fprintf(spacing);
fprintf('LFM omega: %2.4f\n', kern.omega)
fprintf(spacing);
fprintf('LFM alpha: %2.4f\n', kern.alpha)
fprintf(spacing);
fprintf('LFM gamma: %2.4f\n', kern.gamma)
fprintf(spacing);
fprintf('LFM Damping Ratio: %2.4f\n', kern.zeta)
fprintf(spacing);
fprintf('LFM Undamped Natural Frequency: %2.4f\n', kern.omega_0)

