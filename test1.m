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
plot(x,y);
plot(x,y,'o')


%????????Theta?????????
thetas=linspace(0,theta1,21);
theta0=0;
r0=0;
a=0.5;
for idx=1:length(thetas)
    theta=thetas(idx);
    r(idx)= r0*cos(theta-theta0)+sqrt((r0*cos(theta-theta0))^2-(r0^2-a^2));      
end
polar(thetas,r);


%?P1??????Theta2???OP1?????
r0=L1;
a=0.5;
theta0=theta1;
x=sqrt((L1^2+a^2)-2*L1*a*cos(pi-theta2));
theta3=acos((L1^2+x^2-a^2)/(2*L1*x));
thetas=linspace(theta1,theta1+theta3,21);
for idx=1:length(thetas)
    theta=thetas(idx);
    r(idx)= r0*cos(theta-theta0)+sqrt((r0*cos(theta-theta0))^2-(r0^2-a^2));      
end
xslice=a*3;
ybound=y1/x1*xslice;
plot([x1 xslice],[y1 ybound],'--');
polar(thetas,r);




end