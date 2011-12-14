[yvals xvals Xm Xn X] = readData(37.429, -360, 37.4295, 360);
n = size(yvals,1);  % num observations
outputs = zeros(n,2);
F = full(xvals);
lat_min = min(yvals(:,1));
lat_max = max(yvals(:,1));
lon_min = min(yvals(:,2));
lon_max = max(yvals(:,2));
lat_l = int8((lat_max-lat_min)*111200)+1;
lon_l = int8((lon_max-lon_min)*88519)+1;
lat_coord=0;
lon_coord=0;

for index=100:110         % the index we're predicting for
    
    % Calculate the distance. I'll optimize this later.
    W = zeros(n,1);
    tau = 100000;
    for i=1:n
        sqrdist = (F(i,:)-F(index,:))*(F(i,:)-F(index,:))';
        W(i) = exp(-sqrdist/tau);
    end
    
    % Probability map.
    P = zeros(lat_l,lon_l);
    for i=1:n
        if W(i)>.3
            for j=1:lat_l
                for k=1:lon_l
                    lat_coord = lat_min+double(j)/111200;
                    lon_coord = lon_min+double(k)/88519;
                    rsqr = ((lat_coord-yvals(i,1))*111200)^2+((lon_coord-yvals(i,2))*88519)^2;
                    sigma = yvals(i,3);
                    P(j,k)=P(j,k)+W(i)*exp(-rsqr/(2*sigma^2))/(2*sigma^2);
                end
            end
        end
    end
    outputs(index,:) = find(P==max(P(:)))
    
end