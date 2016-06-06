function draw
clear all;
close all;

sample = 100;
alpha = 5;
x = alpha*rand(1,sample);
y = alpha*rand(1,sample);

r = x.^2+y.^2;
theta = atan2(y,x);
rmax = max(r);
thetamax = max(theta);
rdot(1) = 0;
thetadot(1) = 0;
dt = 0.02;
for idx=2:sample
    rdot(idx) = (r(idx)-r(idx-1))/dt;
    thetadot(idx) = (theta(idx)-theta(idx-1))/dt;
end
rdotmax = max(rdot);
thetadotmax = max(thetadot);

v = r.*thetadot;
vmax = max(v);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1200, 500]);

subplot(3,3,[1 4]);
title('Destination');
hold on;
xlim([0,alpha]);
ylim([0,alpha]);

subplot(332);
title('r');
hold on;
xlim([0,sample]);
ylim([0,rmax]);

subplot(335);
title('$$\theta$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,thetamax]);

subplot(333);
title('$$\dot{r}$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,rdotmax]);

subplot(336);
title('$$\dot{\theta}$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,thetadotmax]);

subplot(338);
title('v');
hold on;
xlim([0,sample]);
ylim([0,vmax]);


for idx=1:sample
    subplot(3,3,[1 4]);
    plot(x(idx),y(idx),'ro');
    plot(x(1:idx),y(1:idx),'b-','LineWidth',0.01);
    
    subplot(332);
    plot(r(1:idx),'b-','LineWidth',1)
    
    subplot(335);
    plot(theta(1:idx),'b-','LineWidth',1);
    
    subplot(333);
    plot(rdot(1:idx),'b-','LineWidth',1)
    
    subplot(336);
    plot(thetadot(1:idx),'b-','LineWidth',1);    
    
    subplot(338);
    plot(v(1:idx),'b-','LineWidth',1);    

    drawnow();
    pause(dt);
end


end