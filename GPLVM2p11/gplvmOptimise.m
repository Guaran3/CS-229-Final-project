function model = gplvmOptimise(model, options, lbls);

% GPLVMOPTIMISE Optimise the parameters and points of a GPLVM model.
%
%	Description:
%	model = gplvmOptimise(model, options, lbls);
%% 	gplvmOptimise.m CVS version 1.7
% 	gplvmOptimise.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z


if ~isfield(options, 'prior')
  prior.type = 'gaussian';
  prior = priorParamInit(prior);
  prior.precision = 1;
else
  prior = options.prior;
end

for iterNum = 1:options.extIters

  % Optimise the kernel if required.
  if options.kernIters
    if options.display > 1
      points = lvmTwoDPlot(model.X, lbls);
    end
    model = ivmOptimiseIVM(model, options.display);
    % Update the kernel.
    if options.gplvmKern
      % Make sure we don't also do another active set optimisation.
      options.activeIters = 0;
      % Optimise the active points together with the kernel params.
      model = gplvmOptimiseKernel(model, prior, options.display, ...
                                  options.kernIters);
      if options.display > 1
        if size(model.X, 2) == 2
          for i = 1:size(model.X, 1);
            set(points(i), 'Xdata', model.X(i, 1));
            set(points(i), 'Ydata', model.X(i, 2));
          end
          drawnow
        end
      end
      
    else
      % Just optimise the kernel parameters (we can do this with the IVM)
      model = ivmOptimiseKernel(model, options.display, ...
                                options.kernIters);
    end
    kernDisplay(model.kern);    
  end
  
  % Do the revese mapping if required.
  if options.reverseMap.extIters
    if options.display > 1
      points = gplvm2dPlot(model, lbls);
    end
    model = ivmOptimiseIVM(model, options.display);
    model = gplvmReverseMap(model, options.reverseMap);
    if options.display > 1
      if size(model.X, 2) == 2
        for i = 1:size(model.X, 1);
          set(points(i), 'Xdata', model.X(i, 1));
          set(points(i), 'Ydata', model.X(i, 2));
        end
        drawnow
      end
    end
    if options.display > 1
      points = gplvm2dPlot(model, lbls);
    end
  end
  
  % Optimise active points if required.
  if options.activeIters
    if options.display > 1
      points = gplvm2dPlot(model, lbls);
    end
    model = ivmOptimiseIVM(model, options.display);    
    model = gplvmOptimiseActiveSet(model, prior, options.display, options.activeIters);
    if options.display > 1
      if size(model.X, 2) == 2
        for i = model.I(:)'
          set(points(i), 'Xdata', model.X(i, 1));
          set(points(i), 'Ydata', model.X(i, 2));
        end
        drawnow
      end
    end
  end

  % Optimise the noise model if required.
  if options.noiseIters
    if options.display > 1
      points = gplvm2dPlot(model, lbls);
    end
    model = ivmOptimiseIVM(model, options.display);
    % Update the noise.
    model = ivmOptimiseNoise(model, options.display, options.noiseIters);
    noiseDisplay(model.noise);  
  end
  % Update active set.
  if options.display > 1
    points = gplvm2dPlot(model, lbls);
    drawnow
  end

  % Optimise the non-active set if required.
  if options.pointIters & length(model.J)
    if options.display > 1
      points = gplvm2dPlot(model, lbls);
    end
    model = ivmOptimiseIVM(model, options.display);

    % Iterate through the data updating X positions.
    counter = 0;
    for i = model.J(:)'
      counter = counter + 1;
      model = gplvmOptimisePoint(model, i, prior, options.display, options.pointIters);
      if options.display > 1
        if size(model.X, 2) == 2
          set(points(i), 'Xdata', model.X(i, 1));
          set(points(i), 'Ydata', model.X(i, 2));
          drawnow
        end
      end
      if ~rem(counter, floor(length(model.J)/10))
        fprintf('Finished point %d\n', counter)
      end      
    end
  end
  % Optimise the non-active set using an assumption of temporal
  % continuity if required.
  if options.temporalPointIters & length(model.J)
    if options.display > 1
      points = gplvm2dPlot(model, lbls);
    end
    model = ivmOptimiseIVM(model, options.display);

    % Iterate through the data updating X positions.
    counter = 0;
    Jsort = sort(model.J(:));
    for i = Jsort'
      counter = counter + 1;
      if i>1
        % initalise optimisation with previous point in sequence.
        model.X(i, :) = model.X(i-1, :);
      end
      model = gplvmOptimisePoint(model, i, prior, options.display, options.temporalPointIters);
      if options.display > 1
        if size(model.X, 2) == 2
          set(points(i), 'Xdata', model.X(i, 1));
          set(points(i), 'Ydata', model.X(i, 2));
          drawnow
        end
      end
      if ~rem(counter, floor(length(model.J)/10))
        fprintf('Finished point %d\n', counter)
      end      
    end
  end
end
% Update active set.
if options.display > 1
  points = gplvm2dPlot(model, lbls);
end
model = ivmOptimiseIVM(model, options.display);
