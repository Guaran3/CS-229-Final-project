function model = gpCreate(q, d, X, y, options);

% GPCREATE Create a GP model with inducing varibles/pseudo-inputs.
%
%	Description:
%
%	MODEL = GPCREATE(Q, D, X, Y, OPTIONS) creates a Gaussian process
%	model structure with default parameter settings as specified by the
%	options vector.
%	 Returns:
%	  MODEL - model structure containing the Gaussian process.
%	 Arguments:
%	  Q - input data dimension.
%	  D - the number of processes (i.e. output data dimension).
%	  X - the input data matrix.
%	  Y - the target (output) data.
%	  OPTIONS - options structure as defined by gpOptions.m.
%	
%	
%
%	See also
%	GPOPTIONS, MODELCREATE


%	Copyright (c) 2005, 2006, 2009 Neil D. Lawrence


%	With modifications by Cark Henrik Ek 2007
% 	gpCreate.m CVS version 1.5
% 	gpCreate.m SVN version 536
% 	last update 2009-09-29T11:07:20.000000Z

if size(X, 2) ~= q
  error(['Input matrix X does not have dimension ' num2str(q)]);
end
if size(y, 2) ~= d
  error(['Input matrix y does not have dimension ' num2str(d)]);
end

if any(isnan(y)) & ~options.isMissingData
  error('NaN values in y, but no missing data declared.')
end
if options.isMissingData & options.isSpherical
  error('If there is missing data, spherical flag cannot be set.');
end

model.type = 'gp';



model.approx = options.approx;
  
model.learnScales = options.learnScales;
model.scaleTransform = optimiDefaultConstraint('positive');

model.optimiseBeta = options.optimiseBeta;
model.betaTransform =  optimiDefaultConstraint('positive');  

model.X = X;
model.y = y;




model.q = size(X, 2);
model.d = size(y, 2);
model.N = size(y, 1);

% Set up a mean function if one is given.
if isfield(options, 'meanFunction') & ~isempty(options.meanFunction)
  if isstruct(options.meanFunction)
    model.meanFunction = options.meanFunction;
  else
    if ~isempty(options.meanFunction)
      model.meanFunction = modelCreate(options.meanFunction, model.q, model.d, options.meanFunctionOptions);
    end
  end
end


model.optimiser = options.optimiser;

model.isMissingData = options.isMissingData;
if model.isMissingData
  for i = 1:model.d
    model.indexPresent{i} = find(~isnan(y(:, i)));
  end
end

model.isSpherical = options.isSpherical;

if ~model.isMissingData
  model.bias = mean(y);
  model.scale = ones(1, model.d);
else
  for i = 1:model.d
    if isempty(model.indexPresent{i})
      model.bias(i) = 0;
      model.scale(i) = 1;
    else
      model.bias(i) = mean(model.y(model.indexPresent{i}, i));
      model.scale(i) = 1;
    end
  end
end
if(isfield(options,'scale2var1'))
  if(options.scale2var1)
    model.scale = std(model.y);
    model.scale(find(model.scale==0)) = 1;
    if(model.learnScales)
      warning('Both learn scales and scale2var1 set for GP');
    end
    if(isfield(options, 'scaleVal'))
      warning('Both scale2var1 and scaleVal set for GP');
    end
  end
end
if(isfield(options, 'scaleVal'))
  model.scale = repmat(options.scaleVal, 1, model.d);
end

model.m = gpComputeM(model);
model.computeS = false;
if options.computeS 
  model.computeS = true;
  model.S = model.m*model.m';
  if ~strcmp(model.approx, 'ftc')
    error('If compute S is set, approximation type must be ''ftc''')
  end
end


if isstruct(options.kern) 
  model.kern = options.kern;
else
  model.kern = kernCreate(model.X, options.kern);
end

if isfield(options, 'noise')
  if isstruct(options.noise)
    model.noise = options.noise;
  else
    model.noise = noiseCreate(options.noise, y);
  end

  % Set up noise model gradient storage.
  model.nu = zeros(size(y));
  model.g = zeros(size(y));
  model.gamma = zeros(size(y));
  
  % Initate noise model
  model.noise = noiseCreate(noiseType, y); 
  
  % Set up storage for the expectations
  model.expectations.f = model.y;
  model.expectations.ff = ones(size(model.y));
  model.expectations.fBar = ones(size(model.y));
  model.expectations.fBarfBar = ones(numData, ...
                                     numData, ...
                                     size(model.y, 2));
end



switch options.approx
 case 'ftc'
  model.k = 0;
  model.X_u = [];
  if model.optimiseBeta
    model.beta = options.beta
    if isempty(options.beta)
      error('options.beta cannot be empty if it is being optimised.');
    end
  end
 case {'dtc', 'dtcvar', 'fitc', 'pitc'}
  % Sub-sample inducing variables.
  model.k = options.numActive;
  model.fixInducing = options.fixInducing;
  if options.fixInducing
    if length(options.fixIndices)~=options.numActive
      error(['Length of indices for fixed inducing variables must ' ...
             'match number of inducing variables']);
    end
    model.X_u = model.X(options.fixIndices, :);
    model.inducingIndices = options.fixIndices;
  else
    ind = randperm(model.N);
    ind = ind(1:model.k);
    model.X_u = model.X(ind, :);
  end
  model.beta = options.beta;
end
if model.k>model.N
  error('Number of active points cannot be greater than number of data.')
end
if strcmp(model.approx, 'pitc')
  numBlocks = ceil(model.N/model.k);
  numPerBlock = ceil(model.N/numBlocks);
  startVal = 1;
  endVal = model.k;
  model.blockEnd = zeros(1, numBlocks);
  for i = 1:numBlocks
    model.blockEnd(i) = endVal;
    endVal = numPerBlock + endVal;
    if endVal>model.N
      endVal = model.N;
    end
  end  
end

initParams = gpExtractParam(model);

% This forces kernel computation.
model = gpExpandParam(model, initParams);


