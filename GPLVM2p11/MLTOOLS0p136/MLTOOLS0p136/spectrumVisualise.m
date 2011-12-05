function handle = spectrumVisualise(spectrumValues, convertFile, ...
                                    width, varargin)

% SPECTRUMVISUALISE Helper code for showing an spectrum during 2-D visualisation.
%
%	Description:
%	handle = spectrumVisualise(spectrumValues, convertFile, ...
%                                    width, varargin)
%% 	spectrumVisualise.m CVS version 1.3
% 	spectrumVisualise.m SVN version 24
% 	last update 2006-06-09T17:32:00.000000Z
if nargin < 3
  width = 1000;
end
cData =zeros(length(spectrumValues), width);
if nargin > 1
  spectrumValues = feval(convertFile, spectrumValues, varargin{:});
end
cData(1, 1) = -80;

handle = imagesc(cData);
