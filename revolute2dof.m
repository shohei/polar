function revolute2dof

clear all; close all;

L1=1; L2=1;
thetas = linspace(0,pi/2,101);
xmax=2;
ymax=2;

for idx=1:10
    idx1 = randi(length(thetas));
    theta1 = thetas(idx1);
    idx2 = randi(length(thetas));
    theta2 = thetas(idx2);
    drawRobot(theta1,theta2);
    pause(1);
end

    function drawRobot(theta1,theta2)
        cla;
        hold on;
        plot(0,0,'ro');
        x1 = L1*cos(theta1);
        y1 = L1*sin(theta1);
        x2 = x1+L2*cos(theta1+theta2);
        y2 = y1+L2*sin(theta1+theta2);
        plot([0 x1],[0 y1],'b-');
        plot([x1 x2],[y1 y2],'b-');
        plot(x1,y1,'ro');
        plot(x2,y2,'kd');
        xlim([-xmax xmax]);
        ylim([-ymax,ymax]);
        annotateParams(theta1,theta2);
        annotateAngle(0,0,theta1);
        annotateAngle(x1,y1,theta2);
        highlightAngle(x1,y1,x2,y2,theta1,theta2);
        drawnow;
    end

    function annotateParams(theta1,theta2)
        theta1 = theta1 * 360/(2*pi);
        theta2 = theta2 * 360/(2*pi);
        str = sprintf('$$\\theta 1:%.2f ^{\\circ}$$',theta1);
        str2 = sprintf('$$\\theta 2: %.2f ^{\\circ}$$',theta2);
        text(1.3,1.9,str,'Interpreter','latex','FontSize',14);
        text(1.3,1.75,str2,'Interpreter','latex','FontSize',14);
    end


    function annotateAngle(x,y,theta)
        deg = theta*360/(2*pi);
        str = sprintf('%.2f deg',deg);
        text(x*1.2,y*1.2,str);
    end

    function highlightAngle(x1,y1,x2,y2,theta1,theta2)
        a=0.4;
        plot([0 xmax],[0 0],'k--');
        tilt = y1/x1;
        ybound = tilt*(xmax);
        plot([x1 xmax],[y1 ybound],'k--');
        
        drawFan(1,0,x1,y1,0,0);
        drawFan(xmax,ybound,x2,y2,x1,y1);
%         [t1,r1]=cart2pol(0-x1,0-y1);
%         [t2,r2]=cart2pol(x2-x1,y2-y1);
%         ts = linspace(t1,t2,21);       
%         [t0, r0] = cart2pol(-xmax,0);
%         r1 = r0*cos(ts-t0)+sqrt(r0^2*(cos(ts-t0)).^2-r0^2+a^2)
%         polar(ts,r1,'r-');                       
        %         ts = linspace(t2,t3,21);
        %         r2 = r0*cos(ts-t0)+sqrt(r0^2*(cos(ts-t0)).^2-r0^2+a^2)
        %         polar(ts,r1,'r-');
    end

    function drawFan(x1,y1,x2,y2,x0,y0)
        a = 0.2;
        [t0, r0] = cart2pol(x0,y0);
        [t1,r1]=cart2pol(x1,y1)
        [t2,r2]=cart2pol(x2,y2);
        ts = linspace(t1,t2,21);
        r = r0*cos(ts-t0)+sqrt(r0^2*(cos(ts-t0)).^2-r0^2+a^2);
        polar(ts,r,'r-');                
    end


end