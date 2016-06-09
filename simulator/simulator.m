function draw
clear all;
close all;

alpha = 5;
x = [0,10,8,8,0];
y = [0,2,10,10,0];
sample = length(x);

r = x.^2+y.^2;
theta = atan2(y,x);
rmax = max(r);
thetamax = max(theta);
rdot(1) = 0;
thetadot(1) = 0;
dt = 0.02;
for idx=2:sample
    rdot(idx) = (r(idx)-r(idx-1))/dt;
    thetadot(idx) = (theta(idx)-theta(idx-1))/dt;
end
rdotmax = max(rdot);
thetadotmax = max(thetadot);

v = r.*thetadot;
vmax = max(v);

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 1200, 500]);

subplot(3,3,[1 4]);
title('Destination');
hold on;
xlim([0,10]);
ylim([0,10]);
grid on;
grid minor;

subplot(332);
title('r');
hold on;
xlim([0,sample]);
ylim([0,rmax]);

subplot(335);
title('$$\theta$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,thetamax]);

subplot(333);
title('$$\dot{r}$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,rdotmax]);

subplot(336);
title('$$\dot{\theta}$$','interpreter','latex');
hold on;
xlim([0,sample]);
ylim([0,thetadotmax]);

subplot(338);
title('v');
hold on;
xlim([0,sample]);
ylim([0,vmax]);


for idx=1:sample
    subplot(3,3,[1 4]);
    plot(x(idx),y(idx),'ro');
    plot(x(1:idx),y(1:idx),'b-','LineWidth',0.01);
    x1=x(idx);
    x2=x(idx+1);
    y1=y(idx);
    y2=y(idx+1);
    bresenhamStep(x1,x2,y1,y2);
    
    subplot(332);
    plot(r(1:idx),'b-','LineWidth',1)
    
    subplot(335);
    plot(theta(1:idx),'b-','LineWidth',1);
    
    subplot(333);
    plot(rdot(1:idx),'b-','LineWidth',1)
    
    subplot(336);
    plot(thetadot(1:idx),'b-','LineWidth',1);
    
    subplot(338);
    plot(v(1:idx),'b-','LineWidth',1);
    
    drawnow();
    pause(dt);
end


    function bresenhamStep(x1,x2,y1,y2)
        dX=x2-x1
        dY=y2-y1
        deltaX=abs(dX*2);
        deltaY=abs(dY*2);
        
        plot(x1,y1,'ro');
        plot(x2,y2,'ro');
        plot([x1,x2],[y1,y2],'b-');
        drawnow();
                    
        %case1
        if(deltaX>deltaY&&dX>0)
            disp 'case1'
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
            disp 'case2'
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
            disp 'case3'
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
            disp 'case4'
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