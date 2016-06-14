function acceleration
clear all;
close all;

t = linspace(0,10,101);


%t<=2: 5t
%2<t<8: 10
%t>=8: -5t+10
rdot = (5*t).*(t<=2) + 10*(t>2&t<8) + (-5*t+50).*(t>=8);
r=[0];
for idx=1:length(t)-1
  r(idx+1) = r(idx) + rdot(idx)*(t(idx+1)-t(idx));
end

plot(t,r,'r');
title('r','interpreter','latex');
return;

thetadot = (5*t).*(t<=2) + 10*(t>2&t<8) + (-5*t+50).*(t>=8);
v = sqrt(rdot.^2+(r.^2).*thetadot.^2);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1200, 300]);
set(gcf,'color','w');

subplot(131);
plot(t,rdot,'r');
title('$\dot{r}$','interpreter','latex');
ylim([0 15]);

subplot(132);
plot(t,thetadot,'b');
title('$\dot{\theta}$','interpreter','latex');
ylim([0 15]);

subplot(133);
plot(t,v,'g');
title('$v$','interpreter','latex');





% fig = gcf;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% fig.PaperPositionMode = 'manual';
% print('accel.png','-dpng');
% 
end