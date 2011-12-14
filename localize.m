function [ lat long ] = localize(gps, aps, data)
% this function localizes one particular point of data
% basically using a modified version of the LWLR algorithm
% In this case it takes into account both the geometric
% distance as well as the GP distance. It then creates a 
% grid of likelihoods and selects the highest. 

%[xcoord ycoord] = toMeters(gps(1), gps(2), data);
xcoord = gps(1);
ycoord = gps(2);

tau = 100;
len = size(data.Y,1);
threshold = .3;
largest = max(data.Y);
largest = largest * largest';


% first we get the weights from all the corresponding 
% distances.  
W = zeros(len,1);
for i =1:len
    dist = (data.X(i,:) - aps)*(data.X(i,:) - aps)';
    W(i) = exp(dist/2*tau^2);
end

P = zeros(xcoord + 10 , ycoord + 10);
for i = 1:len
    if W(i) < threshold
        continue;
    end
    for j = (xcoord - 10):(xcoord + 10)
        for k = (ycoord - 10):(ycoord + 10)
            dist = (xcoord - data.Y(i,1))^2 + (ycoord - data.Y(i,2))^2
            sigma = data.E(i)/3;
            if sqrt(dist) < sigma*3
                P(j,k)=P(j,k)+W(i)*exp(-dist/(2*sigma^2))/(2*sigma^2);
            end
        end
    end
end
[row, col] = find(P==max(P));


end

