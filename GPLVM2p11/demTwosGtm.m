
% DEMTWOSGTM For visualising oil data --- uses NETLAB toolbox.
%
%	Description:
%	% 	demTwosGtm.m CVS version 1.4
% 	demTwosGtm.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

rand('state', 1e5);
randn('state', 1e5);


Y = lvmLoadData('twos');

dataDim = size(Y, 2);
latentDim = 2;


latentGridDims = [15 15]; 
numLatent = prod(latentGridDims);  % Number of latent points
numCentres = 16;


% Create and initialise GTM model
model = gtm(latentDim, numLatent, dataDim, numCentres, ...
   'gaussian', 0.1);

options = optOptions;
options(7) = 1;   
model = gtminit(model, options, Y, 'regular', latentGridDims, [4 4]);

options = optOptions;
options(14) = 1000;
options(1) = 1;
options(3) = 1e-6;
[model, options] = gtmem(model, Y, options);

% Plot posterior means
X = gtmlmean(model, Y);
colordef white
figure, hold on
plot(X(:, 1), X(:, 2), 'rx');
