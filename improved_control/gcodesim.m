function gcodesim
clear all;
close all;
format compact;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CAPTURE = false;
REDUCE = true;
SCREENSHOT = false;
SECOND_MONITOR = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


pathname= '/Users/shohei/Documents/MATLAB/Projects/polar/improved_control/';
% filename = 'finger2_mod2.gcode';
filename = 'finger.gcode';

fullpath = sprintf('%s%s',pathname,filename);

fid = fopen(fullpath,'r');

tline = fgets(fid);
global Xold;global Yold;global Eold;global Fold;
Xold=0;
Yold=0;
Eold=0;
Fold=0;

global dx;global dy;global v;global dt;global EE;
global dr;global dtheta;global v2; global r;
global sign_for_dr;global XX;global YY;
dx =[];
dy =[];
v =[];
dt = [];
EE = [];
dr = [];
dtheta=[];
v2=[];
r = [0];
sign_for_dr=[];



figure(1);
axis equal;
s = 60;
% s = 5;
ylim([0,s]);
xlim([-s/2,s/2]);
% xlim([0,130]);
% ylim([0,130]);
hold on;
title('cartesian')
t1 = text(10,55,'$X_{new}$');
t1.Interpreter = 'latex';
t1.FontSize = 15;
t2 = text(10,52,'$Y_{new}$');
t2.Interpreter = 'latex';
t2.FontSize = 15;


if(SECOND_MONITOR)
    
    FigHandle = figure(2);
    set(FigHandle, 'Position', [100, 100, 600, 600]);
    
    subplot(241)
    hold on;
    title('$\Delta x$','interpreter','latex');
    
    subplot(242)
    hold on;
    title('$\Delta y$','interpreter','latex');
    
    subplot(243)
    hold on;
    title('$v_1=\sqrt{\dot{x}^2+\dot{y}^2}$','interpreter','latex');
    
    subplot(244)
    hold on;
    title('$\Delta E$','interpreter','latex');
    ylim([0,3]);
    
    subplot(245)
    hold on;
    title('$\Delta r$','interpreter','latex');
    
    subplot(246)
    hold on;
    title('$\Delta \theta$','interpreter','latex');
    
    subplot(247)
    hold on;
    title('$v_2=\sqrt{\dot{r}^2+r^2 \dot{\theta}^2}$','interpreter','latex');
    ylim([0 1000]);
    
    subplot(248)
    hold on;
    title('$r$','interpreter','latex');
    ylim([0,65]);
    
end

counter=0;

if(CAPTURE)
    writerObj = VideoWriter('newfile.avi');
    open(writerObj);
end


MAXLOOP = 2000;
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
                    figure(1);
                    str1 = sprintf('$X_{new}$: %.2f',Xnew);
                    t1.String = str1;
                    str2 = sprintf('$Y_{new}$: %.2f',Ynew);
                    t2.String = str2;
                    current_point = plot(Xnew,Ynew,'ro');
                    plot([Xold,Xnew],[Yold,Ynew],'b-');
                    drawnow;
                    set(current_point,'Visible','off');                    
                    
                    if(SECOND_MONITOR)
                        figure(2);
                        subplot(241);
                        dx(end+1) = Xnew-Xold;
                        plot(dx,'b');
                        subplot(242);
                        dy(end+1) = Ynew-Yold;
                        plot(dy,'b');
                        subplot(243);
                        dt(end+1) = sqrt(dx(end)^2+dy(end)^2)/Fnew*60;
                        v = sqrt((dx./dt).^2+(dy./dt).^2);
                        plot(v,'b');
                        subplot(244);
                        EE(end+1) = deltaE;
                        plot(EE,'b');
                        sign_for_dr(end+1) = checkSign(Xold,Yold,dx(end),dy(end));
                        
                        dr = sign_for_dr.*sqrt(dx.^2+dy.^2);
                        
                        subplot(245);
                        plot(dr,'b');
                        
                        XX(end+1) = Xnew;
                        YY(end+1) = Ynew;
                        r = sqrt(XX.^2+YY.^2);
                        %                     r(end+1) = r(end) + dr(end);
                        if(isempty(dtheta))
                            dtheta(end+1) = atan2(dy(end),dx(end));
                        else
                            dtheta(end+1) = atan2(dy(end),dx(end))-atan2(dy(end-1),dx(end-1));
                        end
                        subplot(246);
                        plot(dtheta,'b');
                        subplot(247);
                        v2 = sqrt((dr./dt).^2+(r.^2).*(dtheta./dt).^2);
                        plot(v2,'b');
                        
                        subplot(248);
                        plot(r,'b');                        
                    end % end of second monitor
                    
                    if(~REDUCE)
                        drawnow;
                        if(CAPTURE)
                            frame = getframe(gcf);
                            writeVideo(writerObj, frame);
                        end
                        
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
    if(REDUCE)
        if(mod(counter,20)==0)
            drawnow;
            if(CAPTURE)
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
            end
            
        end
    end
    counter=counter+1;
    if(counter>MAXLOOP)
        if(SCREENSHOT)
            fig = gcf;
            fig.PaperUnits = 'inches';
            fig.PaperPosition = [0 0 6 3];
            fig.PaperPositionMode = 'manual';
            print('gcodesim.png','-dpng');
        end
        return;
    end
end

fclose(fid);


    function [S]=checkSign(Xold,Yold,dx,dy)
        if(Xold>0 && Yold >0) %I
            if(dx>0 || dy>0)
                S = 1;
            else
                S = -1;
            end
        elseif(Xold<0 && Yold >0) %II
            if(dx<0 || dy>0)
                S =  1;
            else
                S = -1;
            end
        elseif(Xold<0 && Yold <0) %III
            if(dx<0 || dy<0)
                S = 1;
            else
                S = -1;
            end
        elseif (Xold>0 && Yold <0) %IV
            if(dx>0 || dy<0)
                S = 1;
            else
                S = -1;
            end
        else
            S = 1;
        end
    end


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

if(CAPTURE)
    close(writerObj);
end

end