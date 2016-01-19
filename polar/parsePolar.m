function parsePolar
clear all; close all;

thetas=linspace(0,2*pi,51);
r=1;
ps = [r*cos(thetas)' r*sin(thetas)'];
ps
subplot(1,2,1);
plot(ps(:,1),ps(:,2),'bo');
axis equal;
axis off;


for idx=1:length(ps)
    p=ps(idx,:);
    x=p(1);
    y=p(2);
    r = sqrt(x^2+y^2);
%     theta = atan(y/x);
    theta = atan2(y,x);
    deg = theta*180/pi;
    fprintf('x=%.2f y=%.2f r=%.2f deg=%.2f\n',x,y,r,deg);
    subplot(1,2,2);
    polar(theta,r,'ro');
    hold on;
    drawnow;
end









end