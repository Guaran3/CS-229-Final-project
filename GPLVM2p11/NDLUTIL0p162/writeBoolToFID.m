function writeBoolToFID(FID, name, val)

% WRITEBOOLTOFID Writes a boolean to an FID.
%
%	Description:
%
%	WRITEBOOLTOFID(FID, NAME, VAL) writes a boolean to a stream.
%	 Arguments:
%	  FID - stream to write to.
%	  NAME - name of boolean.
%	  VAL - value of variable to place in file.
%	
%
%	See also
%	READBOOLFROMFID, WRITESTRINGTOFID, WRITEBOOLTOFID, WRITEINTTOFID


%	Copyright (c) 2008 Neil D. Lawrence
% 	writeBoolToFID.m SVN version 23
% 	last update 2008-07-13T19:40:29.000000Z
  
if val
  writeStringToFID(FID, name, '1');
else
  writeStringToFID(FID, name, '0');
end
  
