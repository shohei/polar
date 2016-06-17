function compute_r
clear all;
close all;
format compact;

t = linspace(0,10,101);


% Gcode parser
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathname= '/Users/shohei/Downloads/gehoge/';
filename = 'finger2_mod2.gcode';
fullpath = sprintf('%s%s',pathname,filename);
fid = fopen(fullpath,'r');
tline = fgets(fid);
counter=0;

while ischar(tline)
    [startIndex,endIndex] = regexp(tline,'^G\d*');
    if(~isempty(startIndex))
        Gcommand = tline(startIndex:endIndex);
        switch Gcommand
            case 'G0' % Rapid linear Move
                %disp 'linear move';
            case 'G1' % Linear Move
                %disp 'linear move';
                [isMove,Xnew,Ynew,Enew,Fnew]=linear_move(tline(endIndex+1:length(tline)),Xold,Yold,Eold,Fold);
                deltaE = Enew - Eold;
                if(deltaE~=0 && isMove)
                    dx(end+1) = Xnew-Xold;
                    dy(end+1) = Ynew-Yold;
                    dt(end+1) = sqrt(dx(end)^2+dy(end)^2)/Fnew*60;
                    v = sqrt((dx./dt).^2+(dy./dt).^2);
                    EE(end+1) = deltaE;
                    plot(EE,'b');                                                     
                    dr = sign_for_dr.*sqrt(dx.^2+dy.^2);                    
                    
                    drawnow;
                end
            case 'G161' % Home axes to minimum
                %disp 'home axes';
            case 'G162' % Home axes to maximum
                %disp 'home axes';
            case 'G92' % Set Position
                %disp 'set position';
            case 'G130' % Set digital potentiometer value
                %disp 'do nothing';
            otherwise
                disp 'no line'
        end
    end
    tline = fgets(fid);
    if(mod(counter,50)==0)
      drawnow;           
    end
    counter=counter+1;
end

fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1200, 300]);
set(gcf,'color','w');

subplot(131);
plot(t,v,'g');
title('$v \sim \omega =  \frac{\Delta E}{\Delta t}$','interpreter','latex');

subplot(132);
plot(t,rdot,'r');
title('$\dot{r}$','interpreter','latex');
ylim([0 15]);

subplot(133);
plot(t,thetadot,'b');
title('$\dot{\theta}$','interpreter','latex');
ylim([0 15]);


% fig = gcf;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% fig.PaperPositionMode = 'manual';
% print('accel.png','-dpng');
%
end