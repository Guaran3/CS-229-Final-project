function [xval yval] = toDeg(xin ,yin, xmin, ymin)
% converts values from meters back to degrees

dlat = 110985.506;
dlon =  88519.664;

xval = (xin/dlat) + xmin;
yval = (yin/dlon) + ymin;
