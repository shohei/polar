function [px,py] = bresenhamStep(x1,x2,y1,y2)
px = [];
py = [];
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
    px(1) = nextX;
    py(1) = nextY;
    while (nextX ~= x2)
        if (D >= 0)
            nextY = nextY + 1;
            D = D - deltaX;
        end
        nextX = nextX + 1;
        D = D + deltaY;
        
        px(end+1) = nextX;
        py(end+1) = nextY;
        %plot(nextX, nextY,'r*');
        %drawnow();       
        %pause(dt);
    end
end

%case2
if(deltaX>deltaY&&dX<0&&grad>0)
    D = -deltaY + deltaX / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextX ~= x2)
        if (D < 0)
            nextY = nextY - 1;
            D = D + deltaX;
        end
        nextX = nextX - 1;
        D = D - deltaY;
        
        px(end+1) = nextX;
        py(end+1) = nextY;
        
%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end

%case3
if(deltaX<deltaY&&dX>0&&grad>0)
    D = deltaX - deltaY / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextY ~= y2)
        if (D >= 0)
            nextX = nextX + 1;
            D = D - deltaY;
        end
        nextY = nextY + 1;
        D = D + deltaX;
        
        px(end+1) = nextX;
        py(end+1) = nextY;

%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end

%case4
if(deltaX<deltaY&&dX<0&&grad>0)
    D = -deltaX + deltaY / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextY ~= y2)
        if (D < 0)
            nextX = nextX - 1;
            D = D + deltaY;
        end
        nextY = nextY - 1;
        D = D - deltaX;
        
        px(end+1) = nextX;
        py(end+1) = nextY;

%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end

%case5
if(deltaX>deltaY&&dX>0&&grad<0)
    D =  (-deltaY) + deltaX / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextX ~= x2)
        if (D < 0)
            nextY = nextY - 1;
            D = D + deltaX;
        end
        nextX = nextX + 1;
        D = D + (-deltaY);
        
        px(end+1) = nextX;
        py(end+1) = nextY;

%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end

%case6
if(deltaX>deltaY&&dX<0&&grad<0)
    D =  -(-deltaY) - deltaX / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextX ~= x2)
        if (D >= 0)
            nextY = nextY + 1;
            D = D - deltaX;
        end
        nextX = nextX - 1;
        D = D - (-deltaY);
        
        px(end+1) = nextX;
        py(end+1) = nextY;

%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end

%case7
if(deltaX<deltaY&&dX>0&&grad<0)
    D =  (-deltaX) + deltaY / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextY ~= y2)
        if (D < 0)
            nextX = nextX + 1;
            D = D + deltaY;
        end
        nextY = nextY - 1;
        D = D + (-deltaX);
        
        px(end+1) = nextX;
        py(end+1) = nextY;

%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end

%case8
if(deltaX<deltaY&&dX<0&&grad<0)
    D =  -(-deltaX) - deltaY / 2; %initial value
    nextX=x1;
    nextY=y1;
    px(1) = nextX;
    py(1) = nextY;
    while (nextY ~= y2)
        if (D >= 0)
            nextX = nextX - 1;
            D = D - deltaY;
        end
        nextY = nextY + 1;
        D = D - (-deltaX);
        
        px(end+1) = nextX;
        py(end+1) = nextY;

%         plot(nextX, nextY,'r*');
%         drawnow();        
%         pause(dt);
    end
end


end%function end
