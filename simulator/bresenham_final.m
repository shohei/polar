function compare_velo
clear all;
close all;
format compact;

ax = [5,30];
ay = [5,20];

bx = [5,25];
by = [3,30];

cx = [30,5];
cy = [20,5];

dx = [25,5];
dy = [30,3];

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 600, 700]);

subplot(221);
axis equal;
xlim([0,32]);
ylim([0,32]);
title('$$\Delta x > 0 , |\Delta x| > |\Delta y|$$','interpreter','latex');
hold on;
grid on;
grid minor;
bresenhamStep(ax(1),ax(2),ay(1),ay(2));

subplot(222);
axis equal;
title('$$\Delta x > 0 , |\Delta x| < |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(bx(1),bx(2),by(1),by(2));

subplot(223);
axis equal;
title('$$\Delta x < 0 , |\Delta x| > |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(cx(1),cx(2),cy(1),cy(2));

subplot(224);
axis equal;
title('$$\Delta x < 0 , |\Delta x| < |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(dx(1),dx(2),dy(1),dy(2));


    function bresenhamStep(x1,x2,y1,y2)
        dX=x2-x1;
        dY=y2-y1;
        deltaX=abs(dX*2);
        deltaY=abs(dY*2);
        
        plot(x1,y1,'ro');
        plot(x2,y2,'ro');
        plot([x1,x2],[y1,y2],'b-');
        drawnow();
                    
        %case1
        if(deltaX>deltaY&&dX>0)
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
                
                plot(nextX, nextY,'r*');
                drawnow();
                                
                pause(0.01);
            end            
        end
        
        %case2
        if(deltaX<deltaY&&dX>0)
            D = deltaX - deltaY / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextY ~= y2)
                if (D >= 0)
                    nextX = nextX + 1;
                    D = D - deltaY;
                end
                nextY = nextY + 1;
                D = D + deltaX;
                
                plot(nextX, nextY,'r*');
                drawnow();
                                
                pause(0.01);
            end            
        end
        
        %case3
        if(deltaX>deltaY&&dX<0)
            D = -deltaY + deltaX / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextX ~= x2)
                if (D < 0)
                    nextY = nextY - 1;
                    D = D + deltaX;
                end
                nextX = nextX - 1;
                D = D - deltaY;
                
                plot(nextX, nextY,'r*');
                drawnow();
                                
                pause(0.01);
            end            
        end
        
        %case4
        if(deltaX<deltaY&&dX<0)
            D = -deltaX + deltaY / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextY ~= y2)
                if (D < 0)
                    nextX = nextX - 1;
                    D = D + deltaY;
                end
                nextY = nextY - 1;
                D = D - deltaX;
                
                plot(nextX, nextY,'r*');
                drawnow();
                                
                pause(0.01);
            end            
        end
       
    end


end