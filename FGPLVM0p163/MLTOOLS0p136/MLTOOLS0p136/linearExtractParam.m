function [params, names] = linearExtractParam(model,dim);

% LINEAREXTRACTPARAM Extract weights from a linear model.
%
%	Description:
%	
%	


%	With modifications by Carl Henrik Ek 2009
% 	linearExtractParam.m CVS version 1.3
% 	linearExtractParam.m SVN version 760
% 	last update 2010-04-13T16:04:31.000000Z
if(nargin<2)
  params = [model.W(:)' model.b];
else
  params = model.W(:,dim);
  params = [params(:)' model.b(dim)];
end

if nargout > 1
  counter = 0;
  for j = 1:size(model.W, 2)
    for i = 1:size(model.W, 1)
      counter = counter + 1;
      names{counter} = ['Weight ' num2str(i) '-' num2str(j)];
    end
  end
    for j = 1:size(model.b, 2)
    counter = counter + 1;
    names{counter} = ['Bias ' num2str(j)];
  end
end
  