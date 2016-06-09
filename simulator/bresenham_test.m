function compare_velo
clear all;
close all;
format compact;

x = [5,30];
y = [5,20];
sample = length(x);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 600, 600]);

subplot(111);
axis equal;
title('Line planning by Bresenham algorithm');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;

bresenhamStep(x(1),x(2),y(1),y(2));

    function bresenhamStep(x1,x2,y1,y2)
        deltaX=x2-x1;
        deltaY=y2-y1;
        deltaX=abs(deltaX*2);
        deltaY=abs(deltaY*2);
        
        subplot(1,1,1);
        plot(x1,y1,'ro');
        plot(x2,y2,'ro');
        plot([x1,x2],[y1,y2],'b-');
        drawnow();
                    
        if(deltaX>deltaY)
            D = deltaY - deltaX / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextX ~= x2)
                if (D >= 0)
                    nextY = nextY + 1;
                    D = D - deltaX;
                end
                nextX = nextX + 1;
                D = D + deltaY;
                
                subplot(1,1,1);
                plot(nextX, nextY,'r*');
                drawnow();
                                
                pause(0.1);
            end            
        end
    end


end