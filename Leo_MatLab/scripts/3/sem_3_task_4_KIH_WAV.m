% sem_3_task_4_KIH_FD.m
clear;

wav_start = 900000;
wav_end = 920000;
wav_first_thread = 1;
wav_second_thread = 2;

wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';
[x,fs] = audioread(wav_path,[wav_start,wav_end-1]);

N = length(x(:,wav_first_thread));

figure('units','normalized','outerposition',[0 0 0.5 1]);

subplot(4,2,1);
plot(x(:,wav_first_thread)), grid minor;
xlabel('time');
ylabel('amp');
title('main wav, first thread');

subplot(4,2,3);
plot(x(:,wav_second_thread)), grid minor;
xlabel('time');
ylabel('amp');
title('main wav, second thread');

X = abs(fft(x(:,wav_first_thread)));
Xm = 2*abs(X)/N;
X = (0:N-1)*fs/N;

subplot(4,2,2);
plot(X, Xm), grid minor;
xlabel('freq');
ylabel('amp');
title('fft of main wav, first thread');

X = abs(fft(x(:,wav_second_thread)));
Xm = 2*abs(X)/N;
X = (0:N-1)*fs/N;

subplot(4,2,4);
plot(X, Xm), grid minor;
xlabel('freq');
ylabel('amp');
title('fft of main wav, second thread');

x_filter = filter(fs3t4, x);

subplot(4,2,5);
plot(x_filter(:,wav_first_thread)), grid minor;
xlabel('time');
ylabel('amp');
title('filtered wav, first thread');

subplot(4,2,7);
plot(x_filter(:,wav_second_thread)), grid minor;
xlabel('time');
ylabel('amp');
title('filtered wav, second thread');

X_filtered = abs(fft(x_filter(:,wav_first_thread)));
Xm_filtered = 2*abs(X_filtered)/N;
X_filtered = (0:N-1)*fs/N;

subplot(4,2,6);
plot(X_filtered, Xm_filtered), grid minor;
xlabel('freq');
ylabel('amp');
title('fft of filtered wav, first thread');

X_filtered = abs(fft(x_filter(:,wav_second_thread)));
Xm_filtered = 2*abs(X_filtered)/N;
X_filtered = (0:N-1)*fs/N;

subplot(4,2,8);
plot(X_filtered, Xm_filtered), grid minor;
xlabel('freq');
ylabel('amp');
title('fft of filtered wav, second thread');
