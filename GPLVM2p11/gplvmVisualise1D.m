function gplvmVisualise1D(model, visualiseFunction, visualiseModify, varargin)

% GPLVMVISUALISE1D Visualise the fantasies along a line (as a movie).
%
%	Description:
%	gplvmVisualise1D(model, visualiseFunction, visualiseModify, varargin)
%% 	gplvmVisualise1D.m CVS version 1.5
% 	gplvmVisualise1D.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z

numFrames = 10000;

numData = size(model.y, 1);

XTest = linspace(min(model.X(:, 1)), max(model.X(:, 1)), numFrames)';
[mu, testYVar] = ivmPosteriorMeanVar(model, XTest);
testY = noiseOut(model.noise, mu, testYVar);
vars = sort(testYVar);
pickPoint = ceil(0.75*numFrames);
maxVar = vars(pickPoint);
figure(1)
imageAxesa = subplot(1, 1, 1);
visHandle = feval(visualiseFunction, model.y(1, :), varargin{:});
set(visHandle, 'erasemode', 'xor')
colormap gray
set(imageAxesa, 'visible', 'off')
for i = 1:size(testY, 1)
  if testYVar(i) < maxVar
    feval(visualiseModify, visHandle, ...
	  testY(i, :), varargin{:});
    pause(0.005)
  end
end