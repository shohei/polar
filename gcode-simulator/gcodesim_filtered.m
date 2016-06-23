function gcodesim_filtered
clear all;
close all;
format compact;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CAPTURE = false;
REDUCE = true;
SCREENSHOT = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIR filter
% wp = 0.4*pi;
% ws = 0.6*pi;
wp = 0.005*pi;
ws = 0.01*pi;
trwidth = ws-wp;
alpha = 6.0;
N = 39;
wc = (wp+ws)/2;
h = fir1(N-1,wc/pi,kaiser(N,alpha));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pathname = '/Users/shohei/Codes/C++/cgc/tests/fixtures/';
% filename = 'jaws.gcode';

% pathname = '/Users/shohei/Downloads/';
% filename = 'oozetest.gcode';

pathname= '/Users/shohei/Downloads/gehoge/';
filename = 'finger2_mod2.gcode';

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
                     dx(end+1) = Xnew-Xold;
                     dy(end+1) = Ynew-Yold;
                    dt(end+1) = sqrt(dx(end)^2+dy(end)^2)/Fnew*60;
                    v = sqrt((dx./dt).^2+(dy./dt).^2);

                    subplot(223);
                    EE(end+1) = deltaE;
                    plot(EE,'b');
                    title('$\Delta E$','interpreter','latex');
                    sign_for_dr(end+1) = checkSign(Xold,Yold,dx(end),dy(end));
                    
                    dr = sign_for_dr.*sqrt(dx.^2+dy.^2);
                                        
                    XX(end+1) = Xnew;
                    YY(end+1) = Ynew;
                    r = sqrt(XX.^2+YY.^2);
                    if(isempty(dtheta))
                        dtheta(end+1) = atan2(dy(end),dx(end));
                    else
                        dtheta(end+1) = atan2(dy(end),dx(end))-atan2(dy(end-1),dx(end-1));
                    end
                    
                    subplot(221);
                    v2 = sqrt((dr./dt).^2+(r.^2).*(dtheta./dt).^2);
                    plot(v2,'b');
                    title('$SNW$','interpreter','latex');
                    
                    filtered = conv(h,v2);
                    subplot(222);
                    plot(filtered,'b');
                    title('Filtered $SNW$','interpreter','latex');
                    
                    subplot(224);
                    plot(r,'b');
                    title('$r$','interpreter','latex');

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