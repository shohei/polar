function prismatic2dof
clear all; close all;    
xmax=5;
ymax=5;

r = 1;
theta = pi/4;

x0 = 0.3;
y0 = 0.5;

x1 = 1;
y1 = 2;
x2 = 4;
y2 = 0.02;
hold on;

xlim([-xmax xmax]);
ylim([-ymax ymax]);

axis equal;
plot([0 xmax],[0 0],'k--');
plot([0 0],[0 ymax],'k--');
plot(x1,y1,'bo');
plot(x2,y2,'bo');
plot([x0 x1],[y0 y1],'k-');
plot([x0 x2],[y0 y2],'k-');

[theta1,r1]=cart2pol(x1,y1);
[theta2,r2]=cart2pol(x2,y2);
a=min(r1,r2)*0.5;
thetas = linspace(theta1,theta2,21);
[theta0, r0] = cart2pol(x0,y0);
r = r0*cos(thetas-theta0)+sqrt(r0^2*(cos(thetas-theta0)).^2+a^2-r0^2);
polar(thetas,r,'r-');





% subplot(1,2,1);
% hold on;
% title('Forward kinematics');
% 
% alpha = pi/4;
% 
% 
% 
% subplot(1,2,2);
% hold on;
% title('Inverse kinematics');
% 
% 
% 
%     function forward
%         
%     end
% 
% 
%     function inverse
%         
%     end
% 

end