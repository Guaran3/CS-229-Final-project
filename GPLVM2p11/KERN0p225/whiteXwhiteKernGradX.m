function gX =  whiteXwhiteKernGradX(whiteKern1, whiteKern2, X, X2) 

% WHITEXWHITEKERNGRADX
%
%	Description:
%	gX =  whiteXwhiteKernGradX(whiteKern1, whiteKern2, X, X2) 
%% 	whiteXwhiteKernGradX.m SVN version 326
% 	last update 2009-04-23T11:33:43.000000Z

if nargin < 3,    
    X2 = X;
else
    U = X;
    X = X2;
    X2 = U;
end
    

gX = zeros(size(X2, 1), size(X2, 2), size(X, 1));