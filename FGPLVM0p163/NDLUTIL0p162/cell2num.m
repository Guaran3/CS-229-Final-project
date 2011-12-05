function out = cell2num(inCell)

% CELL2NUM Converts a cell array of strings to numbers.
%
%	Description:
%
%	OUT = CELL2NUM(INCELL) converts a cell array of strings to numbers.
%	 Returns:
%	  OUT - the output array.
%	 Arguments:
%	  INCELL - the input cell array.
%	
%
%	See also
%	STR2NUM, CELL2MAT


%	Copyright (c) 2010 Neil D. Lawrence
% 	cell2num.m SVN version 797
% 	last update 2010-04-12T22:06:06.000000Z

  if nargin < 3
    before = true;
    if nargin < 2
      padding = ' ';
    end
  end

  lengths = cellfun('length', inCell);
  maxLength = max(lengths);
  maxPad = maxLength - min(lengths);
  out = zeros(length(inCell), 1);
  for i = 0:maxPad
    ind = find(lengths==maxLength-i);
    if length(ind)==0
      continue
    end
    out(ind) = str2num(cat(1, inCell{ind}));
  end
end