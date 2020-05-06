clear, clc, close all;

fs = 40000;
ts = 0 : 1/fs : 0.05-1/fs;
n = length(ts);

fc = cos(2*pi*1000*ts);
fm = sin(2*pi*50*ts);

x = fc.*fm;

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0 0.5 0.5 0.5]);
plot(ts,x), grid minor, title('AM signal');
xlabel('time');
ylabel('amplitude');

y = filter(flh5,abs(x));

figure('Name','Figure 2','units','normalized',...
    'outerposition',[0.5 0.5 0.5 0.5]);
plot(ts,x), grid minor, hold on;
plot(ts,y), ylim([-1 1]);
title('Get envelope using the lowpass filter');
xlabel('time');
ylabel('amplitude');
legend({'Base freq';'Env freq'});

z = hilbert(x);

figure('Name','Figure 3','units','normalized',...
    'outerposition',[0.5 0 0.5 0.5]);
plot(ts,x), grid minor, hold on;
plot(ts,abs(z)), ylim([-1 1]);
title('Get envelope using the Hilbert transform');
xlabel('time');
ylabel('amplitude');
legend({'Base freq';'Env freq'});
