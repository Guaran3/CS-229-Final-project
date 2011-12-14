[yvals xvals Xm Xn X] = readData(37.429, -360, 37.4295, 360);
n = size(yvals,1);  % num observations
outputs = zeros(n,2);
F = full(xvals);
for i=1:n
    for j=1:size(F,2)
        if F(i,j)~=0
            F(i,j)=F(i,j)+100;
        end
    end
end

scale_lat=111200*2;
scale_lon = 88519*2;
lat_min = min(yvals(:,1));
lat_max = max(yvals(:,1));
lon_min = min(yvals(:,2));
lon_max = max(yvals(:,2));
lat_l = int8((lat_max-lat_min)*scale_lat)+1;
lon_l = int8((lon_max-lon_min)*scale_lon)+1;
lat_coord=0;
lon_coord=0;

tau = 10000;
threshold = .3;

for index=1:n         % the index we're predicting for
    
    % Calculate the distance. I'll optimize this later.
    W = zeros(n,1);
    for i=1:n
        sqrdist = (F(i,:)-F(index,:))*(F(i,:)-F(index,:))';
        W(i) = exp(-sqrdist/tau);
    end
    
    % Probability map.
    P = zeros(lat_l,lon_l);
    for i=1:n
        if W(i)>threshold
            for j=1:lat_l
                for k=1:lon_l
                    lat_coord = lat_min+double(j)/scale_lat;
                    lon_coord = lon_min+double(k)/scale_lon;
                    rsqr = ((lat_coord-yvals(i,1))*scale_lat)^2+((lon_coord-yvals(i,2))*scale_lon)^2;
                    sigma = yvals(i,3)/3;
                    P(j,k)=P(j,k)+W(i)*exp(-rsqr/(2*sigma^2))/(2*sigma^2);
                end
            end
        end
    end
    [row,col] = find(P==max(P(:)));
    outputs(index,:)=[row/scale_lat+lat_min col/scale_lon+lon_min];
    
end

n_outputs = outputs;
for i = 1:n
    n_outputs(i,1) = n_outputs(i,1) +rand(1)*.0001;
    n_outputs(i,2) = n_outputs(i,2) +rand(1)*.0001;
end
scatter(n_outputs(:,1), n_outputs(:,2))