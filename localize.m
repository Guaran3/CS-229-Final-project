function [ lat long ] = localize(gps, aps, data)
% this function localizes one particular point of data
% basically using a modified version of the LWLR algorithm
% In this case it takes into account both the geometric
% distance as well as the GP distance. It then creates a 
% grid of likelihoods and selects the highest. 



end

