[yvals xvals Xm Xn X] = readData(37.429, -360, 37.4295, 360);
SD = distmat(full(xvals));    % Signal Distance
GD = distmat(yvals(:,1:2));   % Geographical Distance

P = zeros([size(GD)]);
for i=1:size(P,1)
    P(i,:)=exp(10000*(-GD(i,:).^2)/yvals(i,3));
    P(i,:)=P(i,:)/sum(P(i,:));
end

R = P*yvals(:,1:2);
%scatter(yvals(:,1), yvals(:,2))
scatter(R(:,1), R(:,2))