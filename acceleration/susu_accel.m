function susu_accel

clear all;
close all;

SCREENSHOT = true;

a = 1;
T = 100;
p0 = 50;
pc = 20;

p = [];
for t=1:T
    if(t<30)
        p(t) = p0 - a*t;        
    elseif(t<70)
        p(t) = pc;
    else    
        p(t) = -50 + a*t;        
    end
end
subplot(151);
plot(p);

ts = [p(1)];
xs = [1];
for i=1:length(p)
  ts(i+1) = ts(i) + p(i);
  xs(i+1) = i+1;
end
subplot(152);
plot(xs,ts);
title('x');

subplot(153);
dx = diff(xs);
dt = diff(ts);
v = dx./dt;
plot(v);
title('v');
vmax = max(v);
ylim([0 vmax]);

dv = diff(v);
dtt = dt(1:end-1);
a = dv./dtt;
subplot(154);
plot(a);
title('a');

da = diff(a);
dttt = dt(1:end-2);
jerk = da./dttt;
subplot(155);
plot(jerk);
title('jerk');

if(SCREENSHOT)
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 6 3];
    fig.PaperPositionMode = 'manual';
    print('susu_accel.png','-dpng');
end



end