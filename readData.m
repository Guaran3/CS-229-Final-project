function [yvals xvals] = readData( minlat, minlong, maxlat, maxlong )
%READDATA Summary of this function goes here
%   Detailed explanation goes here

fh = fopen('parsedData.txt', 'r');
raw = textscan(fg, '%[^\n\r]');
raw = raw{1,1}

for i=1:length(raw)
    current = raw{i};
    [time  current] = strtok(current, ' ');
    [lat   current] = strtok(current, ' ');
    [long  current] = strtok(current, ' ');
    [error current] = strtok(current, ' ');
    time  = str2double(time);
    lat   = str2double(lat);
    long  = str2double(long);
    error = str2double(error);
    currentY = [time lat long error];
    currentX = [];
    while ~isempty(current)
        




end

