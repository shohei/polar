function test1
clear all; close all;
hold on;

L1=1;
L2=1;
theta1=30*pi/180;
theta2=20*pi/180;

x1=L1*cos(theta1);
y1=L2*sin(theta1);
x2=L1*cos(theta1)+L2*cos(theta1+theta2);
y2=L1*sin(theta1)+L2*sin(theta1+theta2);
x=[0 x1 x2];
y=[0 y1 y2];

plot(x,y,'b-','LineWidth',2.5);
plot(x,y,'bo')

drawAngle(0,0,theta1);
drawAngle(L1,theta1,theta2);

%?P1??????Theta2???OP1?????


    function drawAngle(r0,th1,th2)
        a=0.5;
        th0=th1;
        x=sqrt((L1^2+a^2)-2*L1*a*cos(pi-th2));
        th3=acos((L1^2+x^2-a^2)/(2*L1*x));
        
        if r0~=0
            thetas=linspace(th1,th1+th3,21);
        else
            thetas=linspace(th1,th2,21);
        end
        
        for idx=1:length(thetas)
            theta=thetas(idx);
            r(idx)= r0*cos(theta-th0)+sqrt((r0*cos(theta-th0))^2-(r0^2-a^2));
        end
        xslice=a*3;
        ybound=y1/x1*xslice;
        plot([x1 xslice],[y1 ybound],'k--');
        polar(thetas,r,'r-');                        
    end


end