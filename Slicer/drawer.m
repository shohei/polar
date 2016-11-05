function drawer
filename='out.txt';
pathname= '/Users/shohei/Documents/MATLAB/Projects/polar/Slicer/';
filename = 'out2.txt';
fullpath = sprintf('%s%s',pathname,filename);
fid = fopen(fullpath,'r');
tline = fgets(fid);

figure();
hold on;

while ischar(tline)
  a = strsplit(tline,',');
  alength = length(a)/2;
  b=[];
  c=[];
  for idx=1:alength
     b(end+1) = str2double(a(2*idx-1));
     c(end+1) = str2double(a(2*idx));
  end
  
  cconst = rand(1,3);
  for idx=1:alength-1
%     plot([b(idx),c(idx)],[b(idx+1),c(idx+1)],'-','color',cconst);
    plot(b(idx),c(idx),'o','color',cconst);
    drawnow;
  end
  
%   pause(0.1);
  tline = fgets(fid);
end    


fclose(fid);



end