function compare_velo
clear all;
close all;
format compact;

x = [5,30];
y = [5,20];
sample = length(x);

deltaX=x(2)-x(1);
deltaY=y(2)-y(1);
deltaX=abs(deltaX*2);
deltaY=abs(deltaY*2);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 600, 600]);

subplot(111);
axis equal;
title('Destination');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;



for idx=1:sample
    subplot(1,1,1);
    plot(x(idx),y(idx),'ro');
    plot(x(1:idx),y(1:idx),'b-');
 
    drawnow();
end


if(deltaX>deltaY)
 D = deltaY - deltaX / 2; %initial value
 nextX=x(1);
 nextY=y(1);
 while (nextX ~= x(2)) 
%           fraction>=0????Q(a+i+1,b+j+1)???
%           ????nextX,nextY???+1
            if (D >= 0) 
                nextY = nextY + 1;      %y?1????
                D = D - deltaX;  %fraction?deltaX??            
            end
%           fraction<0????P(a+i+1,b+j)???
%           ????nextX??+1
            nextX = nextX + 1;      %// x?1????
            D = D + deltaY;  %// fraction?deltaY???

            subplot(1,1,1);
            plot(nextX, nextY,'r*');
            drawnow();
            pause(0.02);
 end

end