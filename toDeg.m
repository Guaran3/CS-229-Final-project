function [xval yval] = toDeg(xin ,yin, data)
% converts values from meters back to degrees

xval = (xin/data.dlat) + data.xmin;
yval = (yin/data.dlon) + data.ymin;
