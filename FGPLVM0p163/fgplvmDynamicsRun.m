function fgplvmDynamicsRun

% FGPLVMDYNAMICSRUN Runs auto regressive dynamics in a forward manner.
%
%	Description:
%
%	FGPLVMDYNAMICSRUN runs auto regressive dynamics in a forward manner
%	until the global variable visualiseInfo.runDynamics is set false..
%	
%
%	See also
%	FGPLVMADDDYNAMICS, FGPLVMVISUALISE


%	Copyright (c) 2005, 2006 Neil D. Lawrence
% 	fgplvmDynamicsRun.m CVS version 1.5
% 	fgplvmDynamicsRun.m SVN version 29
% 	last update 2007-11-03T14:33:02.000000Z

global visualiseInfo

while visualiseInfo.clicked & visualiseInfo.runDynamics
  % This should be changed to a model specific visualisation.
  x = visualiseInfo.latentPos(1);
  y = visualiseInfo.latentPos(2);
  set(visualiseInfo.latentHandle, 'xdata', x, 'ydata', y);
  fhandle = str2func([visualiseInfo.model.type 'PosteriorMeanVar']);
  [mu, varsigma] = fhandle(visualiseInfo.model, visualiseInfo.latentPos);
  if isfield(visualiseInfo.model, 'noise')
    Y = noiseOut(visualiseInfo.model.noise, mu, varsigma);
  else
    Y = mu;
  end
  visualiseInfo.visualiseModify(visualiseInfo.visHandle, ...
                                Y, visualiseInfo.varargin{:});
  visualiseInfo.latentPos = modelSamp(visualiseInfo.model.dynamics, ...
                                      visualiseInfo.latentPos);
  pause(0.1)
end



