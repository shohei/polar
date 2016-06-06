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

% drawRandTheta();

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 900, 400]);

subplot(2,2,[1 3]);
title('Destination');
hold on;
xlim([0,alpha]);
ylim([0,alpha]);

subplot(222);
title('r');
hold on;
xlim([0,sample]);
ylim([0,rmax]);

subplot(224);
title('$$\theta$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,thetamax]);

for idx=1:sample
    subplot(2,2,[1 3]);
    plot(x(idx),y(idx),'ro');
    
    subplot(222);
    plot(r(1:idx),'b-','LineWidth',1)
    
    subplot(224);
    plot(theta(1:idx),'b-','LineWidth',1);
    
    drawnow();
    pause(0.02);
end


end