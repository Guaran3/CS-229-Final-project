function [yvals xvals] = readData( minlat, minlong, maxlat, maxlong )
%READDATA Summary of this function goes here
%   Detailed explanation goes here

fg = fopen('parsedData.txt', 'r');
raw = textscan(fg, '%[^\n\r]');
raw = raw{1,1};

Y  = [];
Xm = [];
Xn = [];
X  = [];
MAClist = [];
item = 1

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
    if lat < minlat || lat > maxlat || long < minlong || long > maxlong
        continue
    end
    currentY = [lat long error];
    currentX = [];

    while ~isempty(current)
        [temp current] = strtok(current, ' ');
        [mac strength] = strtok(temp, ':');
        if isempty(mac)
            break;
        end
        mac = str2double(mac);
        strength = str2num(strength(2:length(strength)));
        if isempty(find(MAClist==mac))
            MAClist = [MAClist mac];
        end
        Xm = [Xm item];
        Xn = [Xn find(MAClist==mac)];
        X = [X strength];
         
    end
    item = item + 1;
    Y = [Y; currentY];

end

yvals = Y;
xvals = sparse(Xm, Xn, X);

