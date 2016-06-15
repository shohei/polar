function acceleration
clear all;
close all;

t = linspace(0,10,101);


%t<=2: 2t+6
%2<t<8: 10
%t>=8: -2t+26
rdot = (2*t+6).*(t<=2) + 10*(t>2&t<8) + (-2*t+26).*(t>=8);
r=[0];
for idx=1:length(t)-1
    r(idx+1) = r(idx) + rdot(idx)*(t(idx+1)-t(idx));
end
thetadot = (2*t+6).*(t<=2) + 10*(t>2&t<8) + (-2*t+26).*(t>=8);
v = sqrt(rdot.^2+(r.^2).*thetadot.^2);

v2 = sqrt(rdot.^2+thetadot.^2);

s=[0];
for idx=1:length(t)-1
    s(idx+1) = s(idx) + v(idx)*(t(idx+1)-t(idx));
end

% polar(r,r);
% return

    function drawPosition()
        subplot(121);
        plot(t,r,'r');
        title('r','interpreter','latex');
        
        subplot(122);
        plot(t,s,'b');
        title('s','interpreter','latex');
        
        set(gcf,'color','w');
        fig = gcf;
        fig.PaperUnits = 'inches';
        fig.PaperPosition = [0 0 6 3];
        fig.PaperPositionMode = 'manual';
        print('displacement.png','-dpng');
    end

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
title('$v=\sqrt{\dot{r}^2+r^2 \dot{\theta}^2}$','interpreter','latex');



% fig = gcf;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% fig.PaperPositionMode = 'manual';
% print('accel.png','-dpng');
%
end