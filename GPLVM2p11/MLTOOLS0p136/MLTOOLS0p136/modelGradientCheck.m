function modelGradientCheck(model, varargin)

% MODELGRADIENTCHECK Check gradients of given model.
%
%	Description:
%
%	MODELGRADIENTCHECK(MODEL, ...) checks the supplied gradient function
%	and the supplied objective function to ensure that the numerical
%	gradients (as computed with the objective function) match the
%	analytically computed gradients.
%	 Arguments:
%	  MODEL - the model for which gradients are to be checked.
%	  ... - additional arguments that are passed to the objective and
%	   gradient functions (after the parameter vector which is always
%	   assumed to be the first argument passed).
%	
%
%	See also
%	MODELOBJECTIVE, MODELGRADIENT, MODELCREATE


%	Copyright (c) 2007 Neil D. Lawrence
% 	modelGradientCheck.m CVS version 1.1
% 	modelGradientCheck.m SVN version 844
% 	last update 2010-05-21T07:08:01.000000Z

[params, names] = modelExtractParam(model);
if length(names) == 0
  for i = 1:model.numParams
    names{i} = ['Param ' num2str(i)];
  end
end

if length(names) ~= length(params)
  error('Names array does not match length of params array');
end

L = 0;
change = 1e-6;
origParams = params;
for i = 1:length(params)
  params(i) = origParams(i) + change;
  Lplus = modelObjective(params, model, varargin{:});
  params(i) = origParams(i) - change;
  Lminus = modelObjective(params, model, varargin{:});
  diff(i) = (Lplus - Lminus)/(2*change);
  params(i) = origParams(i);
end

anal = modelGradient(origParams, model, varargin{:});

delta = anal-diff;

paramMaxDiff = max(max(abs(diff-anal)));
if paramMaxDiff > 100*change
  l = 0;
  for i = 1:length(names)
    if l < length(names{i})
      l = length(names{i});
    end
  end
  
  fprintf([char(repmat(32, 1, l)) '\tanalytic   diffs     delta\n']);
  for i = 1:length(names)
    if(abs(delta(i)/max([abs(anal(i)) 1]))>=1e-4)

      spaceLen = l - length(names{i});
      space = char(repmat(32, 1, spaceLen));
      fprintf([space names{i} ':\t%4.6f\t%4.6f\t%4.6f\n'], ...
              anal(i), diff(i), diff(i) - anal(i));
    end
  end

end
fprintf('Param max diff: %2.6f.\n', paramMaxDiff);
