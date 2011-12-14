[yvals xvals Xm Xn X] = readData(-360, -360, 360, 360);
SD = distmat(full(xvals)); % Signal Distance
GD = distmat(yvals);       % Geographical Distance

P = zeros([size(GD)]);
for i=1:size(P,1)
    P(i,:)=exp((-GD(i,:).^2/(2*yvals(i,3)^2))-SD(i,:).^2);
    P(:,i)=P(:,i)/sum(P(:,i));
end

R = P*yvals(:,1:2);
%scatter(yvals(:,1), yvals(:,2))
scatter(R(:,1), R(:,2))