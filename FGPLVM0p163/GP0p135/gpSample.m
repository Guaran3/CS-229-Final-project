function f = gpSample(kernType, numSamps, params, lims, seed, bw)

% GPSAMPLE Create a plot of samples from a GP.
%
%	Description:
%
%	GPSAMPLE(KERNTYPE, NUMSAMPS, PARAMS, LIMS) creates a plot of samples
%	from a kernel with the given parameters and variance.
%	 Arguments:
%	  KERNTYPE - the type of kernel to sample from.
%	  NUMSAMPS - the number of samples to take.
%	  PARAMS - parameter vector for the kernel.
%	  LIMS - limits of the x axis.


%	Copyright (c) 2008 Neil D. Lawrence
% 	gpSample.m SVN version 118
% 	last update 2008-12-03T11:00:55.000000Z
  
if nargin < 6
  bw = false;
  if nargin < 5
    seed = [];
    if nargin < 4
      lims = [-3 3];
      if nargin < 3
        params = [];
        if nargin < 2
          numSamps = 10;
        end
      end
    end
  end
end
if ~isempty(seed)
  randn('seed', seed);
  rand('seed', seed);
end
t_star = linspace(lims(1), lims(2), 200)';

kern = kernCreate(t_star, kernType);
if ~isempty(params)
  feval = str2func([kernType 'KernExpandParam']);
  kern = feval(kern, params);
end
feval = str2func([kernType 'KernExtractParam']);
[params, names] = feval(kern);
paramStr = [];
for i = 1:length(names)
  Name = names{i};
  Name(1) = upper(Name(1));
  ind = find(Name==' ');
  Name(ind+1) = upper(Name(ind+1));
  Name(ind) = '';
  paramStr = [paramStr Name num2str(params(i))];
  
end
infoStr = ['Samples' num2str(numSamps) 'Seed' num2str(randn('seed'))];

% Covariance of the prior.
K_starStar = kernCompute(kern, t_star, t_star);

% Sample from the prior.
fsamp = real(gsamp(zeros(size(t_star)), K_starStar, numSamps));

% Plot and save.
clf
linHand = plot(t_star, fsamp);
zeroAxes(gca, 0.025, 18, 'times');
set(linHand, 'linewidth', 2)
if bw
  set(linHand, 'color', [0 0 0])
end
KernType = kernType;
KernType(1) = upper(kernType(1));
fileName = ['gpSample' KernType infoStr paramStr];
printPlot(fileName, '../tex/diagrams', '../html');

