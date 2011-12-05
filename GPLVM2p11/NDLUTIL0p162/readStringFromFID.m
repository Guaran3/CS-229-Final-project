function val = readStringFromFID(FID, string)

% READSTRINGFROMFID Read an boolean from an FID.
%
%	Description:
%
%	VAL = READSTRINGFROMFID(FID, NAME) reads a string from a stream.
%	 Returns:
%	  VAL - value of variable in file.
%	 Arguments:
%	  FID - stream to read from.
%	  NAME - name of string.
%	
%
%	See also
%	WRITESTRINGTOFID, READINTFROMFID, READBOOLFROMFID, READDOUBLEFROMFID


%	Copyright (c) 2008 Neil D. Lawrence
% 	readStringFromFID.m SVN version 23
% 	last update 2008-07-13T19:40:15.000000Z
  
lineStr = getline(FID);
tokens = tokenise(lineStr, '=');
if(length(tokens)~=2 | ~strcmp(tokens{1}, string))
  error('Incorrect file format.')
end
val = tokens{2};
