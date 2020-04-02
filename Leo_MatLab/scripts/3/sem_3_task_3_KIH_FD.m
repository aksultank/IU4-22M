% sem_3_task_3_KIH_FD.m
clear;

fs = 460;   % freq
ts = 0 : 1/fs : 10-1/fs; % count sequence
N = length(ts);     % counts number

f1 = 130;
f2 = 156;
f3 = 219;

x = 0.3*sin(2*pi*f3*ts) + ...
    0.25*sin(2*pi*(f2-47)*ts) + ...
    0.3*sin(2*pi*f1*ts) + ...
    0.15*sin(2*pi*(f1+11)*ts) + ...
    0.7*sin(2*pi*(f3+24)*ts);

figure('units','normalized','outerposition',[0 0 0.5 1]);

subplot(2,2,1);
plot(x(1:1000)), hold on, grid minor;
xlabel('time');
ylabel('amp');
title('main signal');

X = abs(fft(x));
Xm = 2*abs(X)/N;
X = (0:N-1)*fs/N;

subplot(2,2,2);
plot(X, Xm), grid minor;
xlabel('freq');
ylabel('amp');
title('fft of main signal');

x_filter = filter(fs3t3,x);

subplot(2,2,3);
plot(x_filter(1:1000)), grid minor;
xlabel('time');
ylabel('amp');
title('filtered signal');

X_filter = abs(fft(x_filter));
Xm_filter = 2*abs(X_filter)/N;
X_filter = (0:N-1)*fs/N;

subplot(2,2,4);
plot(X_filter, Xm_filter), grid minor;
xlabel('freq');
ylabel('amp');
title('fft of filtered signal');
