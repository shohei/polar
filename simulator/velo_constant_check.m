function velo_constant_check
clear all;
close all;

len = 100;

dtheta = 2*ones(len);
r = [0];
for idx=1:len
  dr = sqrt(1-(r(idx)*dtheta(idx))^2);
  r(idx+1) = r(idx) + dr;
end

r
plot(real(r));


end