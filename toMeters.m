function [xval yval] = toMeters(xin, yin, data)
%converts the position in degrees to position in meters

xval = (xin - data.xmin) * data.dlat;
yval = (yin - data.ymin) * data.dlon;


