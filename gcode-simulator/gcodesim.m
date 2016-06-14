function gcodesim
clear all;
close all;

% pathname = '/Users/shohei/Codes/C++/cgc/tests/fixtures/';
% filename = 'jaws.gcode';

pathname = '/Users/shohei/Downloads/';
filename = 'oozetest.gcode';


fullpath = sprintf('%s%s',pathname,filename);

fid = fopen(fullpath,'r');

tline = fgets(fid);
global Xold;
global Yold;
Xold=0;
Yold=0;
global dx;
dx =[];
global dy;
dy =[];
global v;
v =[];
% global dt;
% dt = [];

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1200, 300]);

subplot(151)
axis equal;
% xlim([-50,50]);
% ylim([-50,50]);
xlim([0,130]);
ylim([0,130]);
hold on;
title('cartesian')

subplot(152)
hold on;
title('$\Delta x$','interpreter','latex');

subplot(153)
hold on;
title('$\Delta y$','interpreter','latex');

subplot(154)
hold on;
title('v','interpreter','latex');

subplot(155)
hold on;
title('$\Delta t$','interpreter','latex');

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
                [Xnew,Ynew]=linear_move(tline(endIndex+1:length(tline)),Xold,Yold);
                subplot(151);
                plot([Xold,Xnew],[Yold,Ynew],'b-');                
                subplot(152);
                dx(end+1) = Xnew-Xold;
                histogram(dx,30);
                subplot(153);
                dy(end+1) = Ynew-Yold;                
                histogram(dy,30);
                subplot(154);
                v = dy./dx;
                histogram(v,30);               
                dt = v./sqrt(dx.^2+dy.^2);                
                subplot(155);                
                plot(dt,'b*');
                drawnow;
                Xold=Xnew;
                Yold=Ynew;
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
    counter
    counter=counter+1;
end

fclose(fid);

    function [Xnew,Ynew]=linear_move(coords,Xold,Yold)
        %         disp(coords);
        [x_st_index,x_end_index] = regexp(coords,'X[\d\.]*?\s');
        [y_st_index,y_end_index] = regexp(coords,'Y[\d\.]*?\s');
        [z_st_index,z_end_index] = regexp(coords,'Z[\d\.]*?\s');
        [e_st_index,e_end_index] = regexp(coords,'E[\d\.]*?\s');
        [f_st_index,f_end_index] = regexp(coords,'F[\d\.]*?\s');
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
            Z = coords(z_st_index+1:z_end_index);
        end
        if(~isempty(e_st_index))
            E = coords(e_st_index+1:e_end_index);
        end
        if(~isempty(f_st_index))
            F = coords(f_st_index+1:f_end_index);
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
        
        Xnew = X
        Ynew = Y
    end


end