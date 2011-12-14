function [xval yval] = toMeters(xin, yin, xmin, ymin)
%converts the position in degrees to position in meters

xval = (xin - xmin) * 110985.506;
yval = (yin - ymin) *  88519.664;

