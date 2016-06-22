function bresenham_final
clear all;
close all;
format compact;

ax = [5,30];
ay = [5,20];

bx = [30,5];
by = [20,5];

cx = [5,25];
cy = [3,30];

dx = [25,5];
dy = [30,3];

%%%%%%%%%%%%%%%%%%%%%
ex = [5,30];
ey = [30,20];

fx = [30,5];
fy = [20,30];

gx = [5,25];
gy = [30,3];

hx = [25,5];
hy = [3,30];

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1000, 700]);

subplot(241);
axis equal;
xlim([0,32]);
ylim([0,32]);
title('$$\Delta x > 0 , \Delta y > 0, |\Delta x| > |\Delta y|$$','interpreter','latex');
hold on;
grid on;
grid minor;
bresenhamStep(ax(1),ax(2),ay(1),ay(2));

subplot(242);
axis equal;
title('$$\Delta x < 0 , \Delta y > 0, |\Delta x| > |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(bx(1),bx(2),by(1),by(2));

subplot(243);
axis equal;
title('$$\Delta x > 0 , \Delta y > 0, |\Delta x| < |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(cx(1),cx(2),cy(1),cy(2));

subplot(244);
axis equal;
title('$$\Delta x < 0 , \Delta y > 0, |\Delta x| < |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(dx(1),dx(2),dy(1),dy(2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(245);
axis equal;
title('$$\Delta x > 0, \Delta y < 0, |\Delta x| > |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(ex(1),ex(2),ey(1),ey(2));

subplot(246);
axis equal;
title('$$\Delta x < 0, \Delta y < 0, |\Delta x| > |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(fx(1),fx(2),fy(1),fy(2));

subplot(247);
axis equal;
title('$$\Delta x > 0, \Delta y < 0, |\Delta x| < |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(gx(1),gx(2),gy(1),gy(2));

subplot(248);
axis equal;
title('$$\Delta x < 0, \Delta y < 0, |\Delta x| < |\Delta y|$$','interpreter','latex');
xlim([0,32]);
ylim([0,32]);
hold on;
grid on;
grid minor;
bresenhamStep(hx(1),hx(2),hy(1),hy(2));


    function bresenhamStep(x1,x2,y1,y2)
        dX=x2-x1;
        dY=y2-y1;
        deltaX=abs(dX*2);
        deltaY=abs(dY*2);
        grad = dY/dX;
        
        plot(x1,y1,'ro');
        plot(x2,y2,'ro');
        plot([x1,x2],[y1,y2],'b-');
        drawnow();
        
        %case1
        if(deltaX>deltaY&&dX>0&&grad>0)
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
        if(deltaX>deltaY&&dX<0&&grad>0)
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
        
        %case3
        if(deltaX<deltaY&&dX>0&&grad>0)
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
        
        %case4
        if(deltaX<deltaY&&dX<0&&grad>0)
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
        
        %case5
        if(deltaX>deltaY&&dX>0&&grad<0)
            D =  (-deltaY) + deltaX / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextX ~= x2)
                if (D < 0)
                    nextY = nextY - 1;
                    D = D + deltaX;
                end
                nextX = nextX + 1;
                D = D + (-deltaY);
                
                plot(nextX, nextY,'r*');
                drawnow();
                
                pause(0.01);
            end
        end
        
        %case6
        if(deltaX>deltaY&&dX<0&&grad<0)
            D =  -(-deltaY) - deltaX / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextX ~= x2)
                if (D >= 0)
                    nextY = nextY + 1;
                    D = D - deltaX;
                end
                nextX = nextX - 1;
                D = D - (-deltaY);
                
                plot(nextX, nextY,'r*');
                drawnow();
                
                pause(0.01);
            end
        end
        
        %case7
        if(deltaX<deltaY&&dX>0&&grad<0)
            D =  (-deltaX) + deltaY / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextY ~= y2)
                if (D < 0)
                    nextX = nextX + 1;
                    D = D + deltaY;
                end
                nextY = nextY - 1;
                D = D + (-deltaX);
                
                plot(nextX, nextY,'r*');
                drawnow();
                
                pause(0.01);
            end
        end
        
        %case8
        if(deltaX<deltaY&&dX<0&&grad<0)
            D =  -(-deltaX) - deltaY / 2; %initial value
            nextX=x1;
            nextY=y1;
            while (nextY ~= y2)
                if (D >= 0)
                    nextX = nextX - 1;
                    D = D - deltaY;
                end
                nextY = nextY + 1;
                D = D - (-deltaX);
                
                plot(nextX, nextY,'r*');
                drawnow();
                
                pause(0.01);
            end
        end
        
        
    end%function end

end