function safeSave(fname, varargin)

% SAFESAVE Safe save
%
%	Description:
%
%	SAFESAVE(FNAME, ...) Saves given variables in such a way that
%	existing files are only overwritten with a complete save, thus
%	making sure that a complete copy exists even if the call is
%	interrupted
%	 Arguments:
%	  FNAME - name of the file to save to (should include extension)
%	  ... - the variables to save (either as names (strings) or as
%	   variables
%	
%
%	See also
%	% SEEALSO SAVE


%	Copyright (c) 2010 Antti Honkela
% 	safeSave.m SVN version 797
% 	last update 2010-05-21T07:08:05.000000Z

  saveargs = cell(size(varargin));
  for k=1:length(varargin),
    if isempty(inputname(k+1)),
      saveargs{k} = varargin{k};
    else
      saveargs{k} = inputname(k+1);
    end
  end
  argstring = sprintf(', ''%s''', saveargs{:});
  
  % First time saving to this file
  if ~exist(fname, 'file'),
    callstr = sprintf('save(''%s''%s)', fname, argstring);
    evalin('caller', callstr);
    return;
  end
  
  % If file exists, first write to a different name
  [pathstr, name, ext, versn] = fileparts(fname);
  tmpfname = fullfile(pathstr,[name '_tmp' ext versn]);
  callstr = sprintf('save(''%s''%s)', tmpfname, argstring);
  evalin('caller', callstr);
  
  % Then move to overwrite the original
  movefile(tmpfname, fname);
end