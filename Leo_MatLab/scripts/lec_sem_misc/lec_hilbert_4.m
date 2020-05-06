clear, clc, close all;
Nh = 128;
n = -Nh/2:Nh/2-1;
h = 1./(pi*n).*(1-cos(pi*n));
h(Nh/2+1) = 0;
h = h.*hamming(Nh)';

fs = 40000;
ts = 0 : 1/fs : 0.01-1/fs;
N = length(ts);
x = cos(2*pi*1000*ts);

y = conv(x,h);
D = round((Nh-1)/2);
xd = [zeros(1,D), x];

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0 0.5 0.5 0.5]);

subplot(2,1,1);
plot(x), grid minor, title('Init signal');
xlabel('time');
ylabel('amplitude');
xlim([0 500]);

subplot(2,1,2);
plot(xd), grid minor, hold on;
plot(y), title('1 KHz  filtered by Hilbert');
xlabel('time');
ylabel('amplitude');
legend({'Real part';'Imag part'});
xlim([0 500]);
