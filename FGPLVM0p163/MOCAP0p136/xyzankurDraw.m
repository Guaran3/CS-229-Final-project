function handle = xyzankurDraw(joint, handle)

% XYZANKURDRAW Helper function for drawing the point cloud from Agarwal and Triggs data.
%
%	Description:
%
%	HANDLE = XYZANKURDRAW(JOINT, HANDLE) draws the stick figure
%	associated with a set of x,y,z points for the Agarwal and Triggs
%	silhouette data.
%	 Returns:
%	  HANDLE - modified graphics handles.
%	 Arguments:
%	  JOINT - the positions of the joints.
%	  HANDLE - graphics handles to modify.
%	
%
%	See also
%	XYZANKURMODIFY, XYZANKURVISUALISE


%	Copyright (c) 2008 Carl Henrik Ek and Neil Lawrence
% 	xyzankurDraw.m SVN version 157
% 	last update 2008-11-29T13:15:19.000000Z


  limb{1} = [2 3;3 4;4 5]; %spine
  limb{2} = [3 6;6 7;7 8;8 9]; % left-arm
  limb{3} = [3 10;10 11;11 12;12 13]; % right-arm
  limb{4} = [2 14;14 15;15 16;16 20]; % left-leg
  limb{5} = [2 17;17 18;18 19;19 21]; % right-leg
  
  
  if(nargin<2)
    % draw figure
    k = 1;
    for(i = 1:1:length(limb))
      linestyle = '-';
      markersize = 20;
      marker = '.';
      for(j = 1:1:size(limb{i},1))
        if (i==3 && j>3) || (i==5 && j>3)
          markersize = 5;
          marker = 's';
        end
        handle(k) = line(joint(limb{i}(j,:),1),joint(limb{i}(j,:),2), ...
                         joint(limb{i}(j,:),3), 'LineWidth', 3, ...
                         'LineStyle', linestyle, ...
                         'Marker', marker, ...
                         'markersize', markersize);
        k = k + 1;
      end
    end
  else
    % modify figure
    k = 1;
    for(i = 1:1:length(limb))
      for(j = 1:1:size(limb{i},1))
        set(handle(k),'Xdata',joint(limb{i}(j,:),1),'Ydata',joint(limb{i}(j,:),2),'Zdata',joint(limb{i}(j,:),3));
        k = k+1;
      end
    end
  end
end
