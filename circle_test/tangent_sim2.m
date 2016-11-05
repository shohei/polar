function tangent_sim2
clear all;
close all;
% h2 as a parameter

CAPTURE = false;
if(CAPTURE)
    writerObj = VideoWriter('newfile.avi');
   inv open(writerObj);
end


l = 10;
a3 = 5;
h1 = 3;
% h2 = 2;
r = 1;
circle1(l,h1,r);

for h2=1.5:0.1:3.5
    b3 = ((l-a3)^2+h1^2-(h2-r)^2)/(2*(h1-h2+r));
    circle3(a3,b3, b3 - h2);
    drawnow;
    if(CAPTURE)
        frame = getframe(gcf);
        writeVideo(writerObj, frame);
    end
    
end


    function h = circle3(x,y,r)
        hold on
        th = 0:pi/50:2*pi;
        xunit = r * cos(th) + x;
        yunit = r * sin(th) + y;
        h = plot(xunit, yunit,'r');
        axis equal;
        xlim([4,12]);
        ylim([0,10]);
    end

    function h = circle1(x,y,r)
        hold on
        th = 0:pi/50:2*pi;
        xunit = r * cos(th) + x;
        yunit = r * sin(th) + y;
        h = plot(xunit, yunit,'b');
        axis equal;
    end


if(CAPTURE)
    close(writerObj);
end



end