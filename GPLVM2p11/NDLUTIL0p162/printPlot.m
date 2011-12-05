function printPlot(fileName, directory, directoryHtml) 

% PRINTPLOT Print a plot to eps and png files.
%
%	Description:
%
%	PRINTPLOT(FILENAME, DIRECTORY, DIRECTORYPNG) prints a plot to the
%	specified file name and directory.
%	 Arguments:
%	  FILENAME - the base name of the file to use.
%	  DIRECTORY - the directory to place the eps files in.
%	  DIRECTORYPNG - the directory to place png the file in.
%	
%
%	See also
%	PREPAREPLOT


%	Copyright (c) 2008 Neil D. Lawrence
% 	printPlot.m SVN version 754
% 	last update 2010-04-12T22:06:06.000000Z

  global printDiagram

  if isempty(printDiagram)
    printTrue = true; % User hasn't been explicit, assume print.
  else
    printTrue = printDiagram; % Use user preference.
  end
  if printTrue
    if nargin < 2 
      directory = '.';
    end
    if nargin < 3
      png = false;
    else
      png = true;
    end
    fprintf('Printing eps plot ...\n');
    print('-depsc', [directory filesep fileName '.eps']) % OCTAVE doesn't
                                                       % include .eps automatically
    if isoctave
      % make a plot with text separated.
      fprintf('Printing epslatex plot ...\n');
      print('-depslatex', [directory filesep fileName '_latex.tex']) 
    end
    cmap = colormap;
    if png
      fprintf('Printing png plot ...\n');
      % make smaller for PNG plot.
      pos = get(gcf, 'paperposition');
      origpos = pos;
      pos(3) = pos(3)/2;
      pos(4) = pos(4)/2;
      set(gcf, 'paperposition', pos);
      fontsize = get(gca, 'fontsize');
      set(gca, 'fontsize', fontsize/2);
      lineWidth = get(gca, 'lineWidth');
      set(gca, 'lineWidth', lineWidth*2);
      print('-dpng', [directoryHtml filesep fileName '.png']);
      set(gcf, 'paperposition', origpos);
      set(gca, 'fontsize', fontsize);
      set(gca, 'lineWidth', lineWidth);
    end
    
    fprintf('Printing black and white eps plot ...\n');
    colormap gray
    print('-deps', [directory filesep fileName 'NoColour.eps']) % Octave
                                                                % doesn't
                                                                % include
                                                                % .eps automatically
    colormap(cmap);
  end
end