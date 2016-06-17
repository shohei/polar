function leib_ramp

clear all;
close all;

FigHandle = figure;
set(FigHandle, 'Position', [100, 100, 800, 400]);

a = 10; %steps per sec^2
F = 2000; %Hz
v = 25;% (steps/s): slew speed: max feedrate
v0 = 5;%(steps/s): base speed

S = (v^2-v0^2) / (2*a)
p1 = F/sqrt(v0^2+2*a)
ps = F/v
R = a/F^2


L = 150; %total steps

p(1) = p1;

for i=1:L
    if(i<S)
        m = -R;
    elseif(i<L-S)
        m = 0;
    else
        m = R;
    end
    
    p(i+1) = p(i) * (1 + m*p(i)*p(i));
    if p(i+1) < ps
        p(i+1) = ps;
    elseif p(i+1) > p1
        p(i+1) = p1;
    end

    subplot(121);
    plot(p);
    title('delay');
    
    subplot(122);
    plot(1./p,'r');
    title('V')
    
    drawnow;
end






end