function tangent_sim
close all;
clear all;

l = 10;
h1 = 5;
h2 = 2;
r = 1;

b3 = 1:10;
blen = length(b3);

circle1(l,h1,r);

for idx=1:blen
  b3i = b3(idx);
  r3i = b3i - h2;
  a3i = l - sqrt(((b3i-h2)+r)^2-(b3i-h1)^2);
  
%   if a3i<0
%    a3i = l - sqrt(((b3i-h2)+r)^2-(b3i-h1)^2);
%   end
% 
%   if a3i > l
%     continue;
%   end

  circle3(a3i,b3i,r3i);
  plot(a3i,h2,'ro');
end

    function h = circle3(x,y,r)
        hold on
        th = 0:pi/50:2*pi;
        xunit = r * cos(th) + x;
        yunit = r * sin(th) + y;
        h = plot(xunit, yunit,'r');
        axis equal;
    end

    function h = circle1(x,y,r)
        hold on
        th = 0:pi/50:2*pi;
        xunit = r * cos(th) + x;
        yunit = r * sin(th) + y;
        h = plot(xunit, yunit,'b');
        axis equal;
    end



end