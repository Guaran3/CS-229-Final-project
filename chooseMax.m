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
lat_min = min(yvals(:,1));
lat_max = max(yvals(:,1));
lon_min = min(yvals(:,2));
lon_max = max(yvals(:,2));
lat_l = int8((lat_max-lat_min)*111200)+1;
lon_l = int8((lon_max-lon_min)*88519)+1;
lat_coord=0;
lon_coord=0;

for index=1:n         % the index we're predicting for
    
    % Calculate the distance. I'll optimize this later.
    W = zeros(n,1);
    tau = 10000;
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
    [row,col] = find(P==max(P(:)));
    outputs(index,:)=[row/111200+lat_min col/88519+lon_min];
    
end
scatter(outputs(:,1), outputs(:,2))