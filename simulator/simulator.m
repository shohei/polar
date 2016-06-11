function draw
clear all;
close all;

% x = [0,10,8,8,0];
% y = [0,2,10,10,0];
x = [0,100,80,80,0];
y = [0,20,100,100,0];

sample = length(x);


FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1200, 500]);

subplot(3,3,[1 4]);
title('Destination');
hold on;
xmax = max(x);
xmin = min(x);
ymax = max(y);
ymin = min(y);
xlim([xmin,xmax]);
ylim([ymin,ymax]);
grid on;
grid minor;

px = [];
py = [];
for idx=1:sample-1
    subplot(3,3,[1 4]);
    plot(x(idx),y(idx),'ro');
    plot(x(1:idx),y(1:idx),'b-','LineWidth',0.01);
    x1=x(idx);
    x2=x(idx+1);
    y1=y(idx);
    y2=y(idx+1);
    [ppx,ppy] = bresenhamStep(x1,x2,y1,y2);
    px = horzcat(px,ppx);
    py = horzcat(py,ppy);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sample = length(px);
dt = 0.01;
r = sqrt(px.^2+py.^2);
theta = atan2(py,px);
theta(end) = theta(end-1);%hack for error
thetadeg = theta*180/pi;
rmax = max(r);
rmin = min(r);
thetamax = max(theta);
thetamin = min(theta);
thetadegmax = max(thetadeg);
thetadegmin = min(thetadeg);
rdot(1) = 0;
thetadot(1) = 0;
for idx=2:sample
    rdot(idx) = (r(idx)-r(idx-1))/dt;
    thetadot(idx) = (theta(idx)-theta(idx-1))/dt;
end
rdotmax = max(rdot);
thetadotmax = max(thetadot);
rdotmin = min(rdot);
thetadotmin = min(thetadot);

v = sqrt(rdot.^2+r.^2+thetadot.^2);

vmax = max(v);
vmin = min(v);

subplot(332);
title('$$r$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([rmin,rmax]);

subplot(335);
title('$$\theta[deg]$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([thetadegmin,thetadegmax]);

subplot(333);
title('$$\dot{r}$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([rdotmin,rdotmax]);

subplot(336);
title('$$\dot{\theta}$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([thetadotmin,thetadotmax]);

subplot(337);
title('$$E$$','interpreter','latex');
hold on;
xlim([0,sample]);

subplot(338);
title('$$\frac{d}{ds} E$$','interpreter','latex');
hold on;
xlim([0,sample]);

subplot(339);
title('$$v=\sqrt{\dot{r}^2+r^2\theta^2 }$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([vmin,vmax]);

for idx=1:sample    
    subplot(3,3,[1 4]);
    plot(px(idx),py(idx),'r*');

    subplot(332);
    plot(r(1:idx),'b-','LineWidth',1)
    
    subplot(335);
    plot(thetadeg(1:idx),'b-','LineWidth',1);
    
    subplot(333);
    plot(rdot(1:idx),'b-','LineWidth',1)
    
    subplot(336);
    plot(thetadot(1:idx),'b-','LineWidth',1);
    
    subplot(339);
    plot(v(1:idx),'b-','LineWidth',1);
    
    drawnow();
    pause(dt);
end


end