clear, clc, close all;

end_s = 0.0128;
file_path = './test_file.txt';
fs = 40000;
ts = 0 : 1/fs : end_s-1/fs;
n = length(ts);

fc = cos(2*pi*4000*ts);
fm = sin(2*pi*350*ts);

x = fc.*fm;

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0.5 0 0.5 0.5]);
plot(ts,x), grid minor, title('AM signal');
xlabel('time');
ylabel('amplitude');

save(file_path,'x','-ascii','-double');
fprintf('Test AM data generated & saved to %s...\n', file_path);
