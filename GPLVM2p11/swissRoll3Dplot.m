
% SWISSROLL3DPLOT 2-D scatter plot of the latent points with color - for Swiss Roll data.
%
%	Description:
%	% 	swissRoll3Dplot.m CVS version 1.3
% 	swissRoll3Dplot.m SVN version 29
% 	last update 2008-01-24T09:56:50.000000Z
y = lvmLoadData('swissRoll');
shade = y(:, 2);
shade = shade - min(shade)+eps;
shade = shade/max(shade);
shade = ceil(shade*64);
x1 = linspace(min(y(:, 1))*1.1, max(y(:, 1))*1.1, 30);
x2 = linspace(min(y(:, 2))*1.1, max(y(:, 2))*1.1, 30);
[X1, X2] = meshgrid(x1, x2);
XTest = [X1(:), X2(:)];
  
figure(1)
clf
% Create the plot for the data
clf
ax = axes('position', [0.05 0.05 0.9 0.9]);
hold on
shading flat
jt = colormap('jet');
gr = colormap('gray');
%colorbar
returnVal = [];
%
for i = 1:size(y, 1)
  returnVal = [returnVal; plot3(y(i, 1), y(i, 2), y(i, 3), 'x')];
end
%for i = 1:length(h)
%  set(h(i), 'facecolor', map(i, :));
%  set(h(i), 'edgecolor', map(i, :));
%end
for i=1:length(returnVal)
  set(returnVal(i), 'color', jt(shade(i), :));
end
xLim = [min(XTest(:, 1)) max(XTest(:, 1))];
yLim = [min(XTest(:, 2)) max(XTest(:, 2))];
set(ax, 'xLim', xLim);
set(ax, 'yLim', yLim);

set(ax, 'fontname', 'arial');
set(ax, 'fontsize', 20);

