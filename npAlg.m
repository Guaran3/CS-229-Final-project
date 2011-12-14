%start by reading in the data points from file.
[yvals xvals] = readData(-360, -360, 360, 360);

% Next, we convert all of the y values into meters, 
% so that we can maintain a consistent unit system
% we also tanslate data so that numbers aren't too high
%
% degree lat = 110985.506 meters
% degree long = 88519.664 meters (at about 37 deg lat)
data.dlat = 110985.506;
data.dlon =  88519.664;

% store the minvalues so we can convert back to the correct format later
data.xmin = min(yvals(:,1));
data.ymin = min(yvals(:,2));
%translate
yvals(:,1) = yvals(:,1) - data.xmin;
yvals(:,2) = yvals(:,2) - data.ymin;
%convert to meters 
yvals(:,1) = yvals(:,1) * data.dlat;
yvals(:,2) = yvals(:,2) * data.dlon;
%separate the gps coords from the error
data.E = yvals(3,:);
yvals = yvals(1:2, :);

%the next task is to flip x values: right now the 
% values of X range from 0 to -99, with 0 being no 
% reading and -99 being the weakest, which is incorrect.
% the simple solution is to just take 100 - val if
% val is non-zero.
X = full(xvals)
for j = 1:size(X, 1)
    for k = 1:size(X, 2)
        if X(j,k) < 0 
            X(j,k) = 100 + X(j,k)
        end
    end
end

% next we create a distance matrix for both the X and Y
% variables to account for decreasing weighting as distance
% increases.  
%data.SD = distmat(full(xvals));
%data.GD = distmat(yvals);

% put the rest of the data in the data struct. mostly
% just to keep functions simple
data.X = X;
data.Y = yvals;
data.E = E;

% now that this script should have all the data turned into
% format, we can call a function that actually starts 
% determining approximate locations of data. 
