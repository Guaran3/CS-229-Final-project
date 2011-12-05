function [channels, skel] = acclaimLoadChannels(fileName, skel)

% ACCLAIMLOADCHANNELS Load the channels from an AMC file.
%
%	Description:
%
%	[CHANNELS, SKEL] = ACCLAIMLOADCHANNELS(FILENAME, SKEL) loads
%	channels from an acclaim motion capture file.
%	 Returns:
%	  CHANNELS - the channels read in for the file.
%	  SKEL - the skeleton for the file.
%	 Arguments:
%	  FILENAME - the file name to load in.
%	  SKEL - the skeleton structure for the file.
%	
%
%	See also
%	ACCLAIMREADSKEL


%	Copyright (c) 2006 Neil D. Lawrence
% 	acclaimLoadChannels.m CVS version 1.2
% 	acclaimLoadChannels.m SVN version 42
% 	last update 2008-08-12T20:23:47.000000Z

fid=fopen(fileName, 'rt');

lin = getline(fid);
lin = strtrim(lin);
while ~strcmp(lin,':DEGREES')
  lin = getline(fid);
  lin = strtrim(lin);
end

counter = 0;
lin = getline(fid);

while lin~=-1
  lin = strtrim(lin);
  parts = tokenise(lin, ' ');
  if length(parts)==1
    frameNo = str2num(parts{1});
    if ~isempty(frameNo)
      counter = counter + 1;
      if counter ~= frameNo
        error('Unexpected frame number.');
      end
    else
      error('Single bone name  ...');
    end
  else
    ind = skelReverseLookup(skel, parts{1});
    for i = 1:length(skel.tree(ind).channels)
      bone{ind}{frameNo}(i) = str2num(parts{i+1});
    end
  end
  lin = getline(fid);
end
fclose(fid);
numFrames = counter;
numChannels = 0;
for i = 1:length(skel.tree)
  numChannels = numChannels + length(skel.tree(i).channels);
end
channels = zeros(numFrames, numChannels);

endVal = 0;
for i =1:length(skel.tree)
  if length(skel.tree(i).channels)>0
    startVal = endVal + 1;
    endVal = endVal + length(skel.tree(i).channels);
    channels(:, startVal:endVal)= reshape([bone{i}{:}], ...
                                          length(skel.tree(i).channels), numFrames)';
    
  end
  [skel.tree(i).rotInd, skel.tree(i).posInd] = ...
      resolveIndices(skel.tree(i).channels, startVal);
end

channels = smoothAngleChannels(channels, skel);

function [rotInd, posInd] = resolveIndices(channels, startVal)

% RESOLVEINDICES Get indices from the channels.

baseChannel = startVal - 1;
rotInd = zeros(1, 3);
posInd = zeros(1, 3);
for i = 1:length(channels)
  switch channels{i}
   case 'Xrotation'
    rotInd(1, 1) = baseChannel + i;
   case 'Yrotation'
    rotInd(1, 2) = baseChannel + i;
   case 'Zrotation'
    rotInd(1, 3) = baseChannel + i;
   case 'Xposition'
    posInd(1, 1) = baseChannel + i;
   case 'Yposition'
    posInd(1, 2) = baseChannel + i;
   case 'Zposition'
    posInd(1, 3) = baseChannel + i;
  end        
end



