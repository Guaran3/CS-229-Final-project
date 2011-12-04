function options = gplvmOptions

% GPLVMOPTIONS Initialise an options stucture.
%
%	Description:
%	options = gplvmOptions
%% 	gplvmOptions.m CVS version 1.5
% 	gplvmOptions.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

% How to display learning, 1 is verbose text and 2 is graphically.
options.display = 0;

% Number of optimisation iterations for the kernel.
options.kernIters = 100;

% Number of optimisation iterations for the noise model.
options.noiseIters = 0;

% Number of optimisation iterations for non-active latent points.
options.pointIters = 100;

% Number of optimisation iterations for non-active points assuming data is temporal
options.temporalPointIters = 0;

% Number of optimisation iterations for active latent points.
options.activeIters = 0;

% How many outer iterations to do.
options.extIters = 15;

% Method for initialising latent points.
options.initX = 'ppca';

% Set to 1 to optimise active set with jointly with kernel parameters.
options.gplvmKern = 0;

% Options for the reverse GP mapping if it is to be used.
options.reverseMap = ivmOptions;
% By default switch off the reverse mapping.
options.reverseMap.extIters = 0;

% Set up prior over latent space.
options.prior.type = 'gaussian';
options.prior = priorParamInit(options.prior);
options.prior.precision = 1;
