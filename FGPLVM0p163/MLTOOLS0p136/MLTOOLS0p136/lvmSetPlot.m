function lvmSetPlot

% LVMSETPLOT Sets up the plot for visualization of the latent space.
%
%	Description:
%
%	LVMSETPLOT sets up the latent space figure for use with the
%	visualization.
%	
%	
%
%	See also
%	% SEEALSO LVMCLASSVISUALISE, LVMVISUALISE, LVMCLICKVISUALISE


%	Copyright (c) 2009 Neil D. Lawrence
% 	lvmSetPlot.m SVN version 589
% 	last update 2009-10-08T13:16:52.000000Z
  
global visualiseInfo

model = visualiseInfo.model;
YLbls = visualiseInfo.lbls;
fhandle = gcf;
cla(visualiseInfo.plotAxes);

lvmScatterPlot(model, YLbls,   visualiseInfo.plotAxes, ...
               [visualiseInfo.dim1, visualiseInfo.dim2], ...
               visualiseInfo.latentPos);
  

set(get(visualiseInfo.plotAxes, 'title'), 'string', 'X', 'fontsize', 30);
set(visualiseInfo.plotAxes, 'position', [0.05 0.05 0.9 0.8]);

% Set up the X limits and Y limits of the main plot
xLim = [min(model.X(:, visualiseInfo.dim1)) max(model.X(:, visualiseInfo.dim1))];
xSpan = xLim(2) - xLim(1);
xLim(1) = xLim(1) - 0.05*xSpan;
xLim(2) = xLim(2) + 0.05*xSpan;
xSpan = xLim(2) - xLim(1);

yLim = [min(model.X(:, visualiseInfo.dim2)) max(model.X(:, visualiseInfo.dim2))];
ySpan = yLim(2) - yLim(1);
yLim(1) = yLim(1) - 0.05*ySpan;
yLim(2) = yLim(2) + 0.05*ySpan;
ySpan = yLim(2) - yLim(1);

set(visualiseInfo.plotAxes, 'XLim', xLim)
set(visualiseInfo.plotAxes, 'YLim', yLim)

numLatentDims = model.q;
numSliders = model.q - 2;

sliderHeight = 0.05;
pos = get(visualiseInfo.plotAxes, 'position');
pos(2) = pos(2) + sliderHeight*numSliders;

a = ver('matlab');
if strcmp(a.Version, '7.0.1')
  menu = 'listbox';
else
  menu = 'popupmenu';
end
if model.q > 2
  pos(3) = pos(3)-0.2;
  for i = 1:model.q
    string{i} = num2str(i);
  end
  uicontrol('Style', 'text', ...
            'Parent', fhandle, ...
            'Units', 'normalized', ...
            'Position',[0.75 0.9 0.1 0.05], ...
            'String', 'X');
  visualiseInfo.xDimension = uicontrol('Style', menu, ...
                                       'Parent', fhandle, ...
                                       'Units', 'normalized', ...
                                       'Position', [0.85 0.9 0.1 0.05], ...
                                       'String', string, ...
                                       'Min', 1, ...
                                       'Max', length(string), ...
                                       'Value', visualiseInfo.dim1);
  h = visualiseInfo.xDimension;
  if(strcmp(menu, 'listbox'))
    set(h, 'listboxtop', get(h, 'value'));
  end
  
  uicontrol('Style', 'text', ...
            'Parent', fhandle, ...
            'Units', 'normalized', ...
            'Position', [0.75 0.85 0.1 0.05], ...
            'String', 'Y');
  visualiseInfo.yDimension = uicontrol('Style', menu, ...
                                       'Parent', fhandle, ...
                                       'Units','normalized', ...
                                       'Position',[0.85 0.85 0.1 0.05], ...
                                       'String', string, ...
                                       'Min', 1, ...
                                       'Max', length(string), ...
                                       'Value', visualiseInfo.dim2);
  
  uicontrol('Parent', fhandle, ...
            'Units','normalized', ...
            'Callback','lvmClassVisualise(''updateLatentRepresentation'')', ...
            'Position',[0.75 0.80 0.2 0.05], ...
            'String','Update');
  
  h = visualiseInfo.yDimension;
  if(strcmp(menu, 'listbox'))
    set(h, 'listboxtop', get(h, 'value'));
  end

  sliderOffset = 0;
  counter = 0;
  for i = model.q:-1:1
    if i ~= visualiseInfo.dim1 && i ~= visualiseInfo.dim2
      counter = counter + 1;
      sliderOffset = sliderOffset + sliderHeight;
      
      xLim = [min(model.X(:, i)) max(model.X(:, i))];
      xSpan = xLim(2) - xLim(1);
      xLim(1) = xLim(1) - 0.05*xSpan;
      xLim(2) = xLim(2) + 0.05*xSpan;
      xSpan = xLim(2) - xLim(1);

      visualiseInfo.latentSlider(counter) = ...
          uicontrol('Style', 'slider', ...
                    'String', 'Time', ...
                    'sliderStep', [xSpan/100, xSpan/10], ...
                    'units', 'normalized', ...
                    'position', [0.1 sliderOffset 0.8 sliderHeight], ...
                    'value', visualiseInfo.latentPos(i), ...
                    'min', xLim(1), ...
                    'max', xLim(2), ...
                    'callback', 'lvmClassVisualise(''latentSliderChange'')');
      visualiseInfo.sliderText(counter) = uicontrol('Style', 'text', ...
                                              'Parent', fhandle, ...
                                              'Units', 'normalized', ...
                                              'Position',[0 sliderOffset 0.1 sliderHeight], ...
                                              'String', num2str(i));
      visualiseInfo.sliderTextVal(counter) = uicontrol('Style', 'text', ...
                                              'Parent', fhandle, ...
                                              'Units', 'normalized', ...
                                              'Position',[0.9 sliderOffset 0.1 sliderHeight], ...
                                              'String', num2str(visualiseInfo.latentPos(i)));
    end
    
  end
end

set(visualiseInfo.plotAxes, 'position', pos);
