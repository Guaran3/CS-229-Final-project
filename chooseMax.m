[yvals xvals Xm Xn X] = readData(37.429, -360, 37.4295, 360);
n = size(yvals,1);  % num observations

index = 100         % the index we're predicting for.
x = yvals(p,:);

% Calculate the distance. I'll optimize this later.
F = full(xvals);
W = zeros(n,1);
for i=1:n
    W(i) = exp(-F(i,:)*F(index,:)');
end


lat_min = min(yvals(:,1));
lat_max = max(yvals(:,1));
lon_min = min(yvals(:,2));
lon_max = max(yvals(:,2));
lat_l = (lat_max-lat_min)*111200+1;
lon_l = (lon_max-lon_min)*111200+1;
lat_coord=0;
lon_coord=0;

% Probability map.
P = zeros(lat,lon);
for i=1:n
    if W(i)==1
        for j=1:lat_l
            for k=1:lon:l
                lat_coord = lat_min+j/111200;
                lon_coord = lon_min+k/111200;
                P(j,k)=P(j,k)+
            end
        end
    end
end