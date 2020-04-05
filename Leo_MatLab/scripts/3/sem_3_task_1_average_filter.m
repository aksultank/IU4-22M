clear;

wav_start = 900000;
wav_end = 900500;
wav_select_thread = 1;
slide_filter_point_number = 11;

wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';
[x,fs] = audioread(wav_path,[wav_start,wav_end-1]);

ts = 0 : 1/fs : wav_end-wav_start-1/fs;
N = length(ts);

y = zeros(1,N+slide_filter_point_number+1);
for i = slide_filter_point_number+1 : length(x(:,wav_select_thread))
%     u must manually edit number of slide filter components!!!
%     so we can do it in double loop, but very lazy
    y(i) = (x(i-1,wav_select_thread)+x(i-2,wav_select_thread)...
        +x(i-3,wav_select_thread)...
        +x(i-4,wav_select_thread)+x(i-5,wav_select_thread)...
        +x(i-6,wav_select_thread)+x(i-7,wav_select_thread)...
        +x(i-8,wav_select_thread)+x(i-9,wav_select_thread)...
        +x(i-10,wav_select_thread)+x(i-11,wav_select_thread)...
        )*1/slide_filter_point_number;
end

x_dirac = zeros(N,1);
x_dirac(slide_filter_point_number) = 1;

y_dirac = zeros(1,N+slide_filter_point_number+1);
for i = slide_filter_point_number+1 : length(x_dirac)
%     u must manually edit number of slide filter components!!!
%     so we can do it in double loop, but very lazy
    y_dirac(i) = (x_dirac(i-1)+x_dirac(i-2)+x_dirac(i-3)+x_dirac(i-4)...
        +x_dirac(i-5)+x_dirac(i-6)+x_dirac(i-7)+x_dirac(i-8)...
        +x_dirac(i-9)+x_dirac(i-10)+x_dirac(i-11))...
        *1/slide_filter_point_number;
end

figure('units','normalized','outerposition',[0 0 0.5 1]);

subplot(2,2,1);
plot(x(:,wav_select_thread)), grid minor;
xlabel('time');
ylabel('amp');
title('Input signal');

subplot(2,2,2);
plot(y(1:wav_end-wav_start)), grid minor;
xlabel('time');
ylabel('amp');
title('Filtered signal');

subplot(2,2,3);
stem(x_dirac(1:(wav_end-wav_start)/20)), grid minor;
xlabel('time');
ylabel('amp');
title('Dirac func');

subplot(2,2,4);
stem(y_dirac(1:(wav_end-wav_start)/10)), grid minor;
xlabel('time');
ylabel('amp');
title('Impulse Characteristic');