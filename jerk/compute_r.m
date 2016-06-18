function compute_r
clear all;
close all;
format compact;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CAPTURE = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1000, 500]);

global Xold;global Yold;global Eold;global Fold;
Xold=0;
Yold=0;
Eold=0;
Fold=0;
global dx;global dy;global dt;global r;global Vscrew;
dx =[];
dy =[];
r = [];
Vscrew=[0];

pathname= '/Users/shohei/Downloads/gehoge/';
filename = 'finger2_mod2.gcode';
fullpath = sprintf('%s%s',pathname,filename);
fid = fopen(fullpath,'r');
tline = fgets(fid);
counter=0;

t(1) = 0;

accel_steps_per_sec = 10;
timer_freq = 2000;
slew_speed = 25;
base_speed = 5;

STEPGAIN = 1000;
EGAIN = 1;

if(CAPTURE)
    writerObj = VideoWriter('newfile.avi');
    open(writerObj);
end

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
                    t(end+1) = t(end) + dt(end);
                    deltaR = sqrt(dx(end)^2+dy(end)^2);
                    totalsteps = deltaR * STEPGAIN;
                    [thetadot,t_stage] = leib_ramp(totalsteps,...
                        accel_steps_per_sec,timer_freq,slew_speed,base_speed);
                    r(end+1) = sqrt(Xnew^2 + Ynew^2);
                    Vscrew(end+1) = EGAIN * deltaE/dt(end);                    
                    subplot(2,3,[1 4]);
                    plot(t,Vscrew);
                    msg = sprintf('G-code line: %d',counter);
                    text(min(t),max(Vscrew),msg);
                    title('$V_{screw}$','interpreter','latex');                    
                    rdot = sqrt(Vscrew(end)^2 - r(end)^2 * thetadot.^2);
                    subplot(2,3,[2 5]);
                    plot(t_stage,thetadot);
                    ylim([0,max(thetadot)]);
                    title('$\dot\theta$','interpreter','latex');
                    subplot(233);
                    plot(t_stage,rdot);
                    ylim([0,max(rdot)]);
                    title('$\dot r$','interpreter','latex');

                    subplot(236);
                    plot(t_stage,rdot,'r');
                    title('$\dot r$ <magnified>','interpreter','latex');

                    drawnow;
                    
                    if(CAPTURE)
                        frame = getframe(gcf);
                        writeVideo(writerObj, frame);
                    end
                    
                    Xold=Xnew;
                    Yold=Ynew;
                    Eold=Enew;
                    Fold=Fnew;                    
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

if(CAPTURE)
    close(writerObj);
end

%% Gcode parser
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [isMove,Xnew,Ynew,Enew,Fnew]=linear_move(coords,Xold,Yold,Eold,Fold)
        %         disp(coords);
        [x_st_index,x_end_index] = regexp(coords,'X-?[\d\.]*?[\s\n]');
        [y_st_index,y_end_index] = regexp(coords,'Y-?[\d\.]*?[\s\n]');
        [z_st_index,z_end_index] = regexp(coords,'Z-?[\d\.]*?[\s\n]');
        [e_st_index,e_end_index] = regexp(coords,'E-?[\d\.]*?[\s\n]');
        [f_st_index,f_end_index] = regexp(coords,'F[\d\.]*?[\s\n]');
        [a_st_index,a_end_index] = regexp(coords,'A[\d\.]*?\s');
        [b_st_index,b_end_index] = regexp(coords,'B[\d\.]*?\s');
        [c_st_index,c_end_index] = regexp(coords,'C[\d\.]*?\s');
        
        if(~isempty(x_st_index))
            X = str2double(coords(x_st_index+1:x_end_index));
        else
            X = Xold;
        end
        if(~isempty(y_st_index))
            Y = str2double(coords(y_st_index+1:y_end_index));
        else
            Y = Yold;
        end
        if(~isempty(z_st_index))
            Z = str2double(coords(z_st_index+1:z_end_index));
        end
        if(~isempty(e_st_index))
            E = str2double(coords(e_st_index+1:e_end_index));
        else
            E = Yold;
        end
        if(~isempty(f_st_index))
            F = str2double(coords(f_st_index+1:f_end_index));
        else
            F = Fold;
        end
        if(~isempty(a_st_index))
            A = coords(a_st_index+1:a_end_index);
        end
        if(~isempty(b_st_index))
            B = coords(b_st_index+1:b_end_index);
        end
        if(~isempty(c_st_index))
            C = coords(c_st_index+1:c_end_index);
        end
        
        Xnew = X;
        Ynew = Y;
        Enew = E;
        Fnew = F;
        
        if(isempty(x_st_index)&&isempty(y_st_index))
            isMove = false;
        else
            isMove = true;
        end
        
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t = linspace(0,10,101);
%t<=2: 2t+6
%2<t<8: 10
%t>=8: -2t+26
% rdot = (2*t+6).*(t<=2) + 10*(t>2&t<8) + (-2*t+26).*(t>=8);
% r=[0];
% for idx=1:length(t)-1
%     r(idx+1) = r(idx) + rdot(idx)*(t(idx+1)-t(idx));
% end
% thetadot = (2*t+6).*(t<=2) + 10*(t>2&t<8) + (-2*t+26).*(t>=8);
% v = sqrt(rdot.^2+(r.^2).*thetadot.^2);
% v2 = sqrt(rdot.^2+thetadot.^2);
%
% s=[0];
% for idx=1:length(t)-1
%     s(idx+1) = s(idx) + v(idx)*(t(idx+1)-t(idx));
% end
%
%
% FigHandle = figure;
% set(FigHandle, 'Position', [100, 100, 1200, 300]);
% set(gcf,'color','w');
%
% subplot(131);
% plot(t,v,'g');
% title('$v \sim \omega =  \frac{\Delta E}{\Delta t}$','interpreter','latex');
%
% subplot(132);
% plot(t,rdot,'r');
% title('$\dot{r}$','interpreter','latex');
% ylim([0 15]);
%
% subplot(133);
% plot(t,thetadot,'b');
% title('$\dot{\theta}$','interpreter','latex');
% ylim([0 15]);


% fig = gcf;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% fig.PaperPositionMode = 'manual';
% print('accel.png','-dpng');
%
end