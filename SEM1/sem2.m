clear;
clear sound;
[x,fs] = audioread('Sound_19998_violin5.ogg');
y=zeros(size(x));
a = 0.8;
d = 4000;
for i = d+1 : length(y)
    y(i,1) = x(i)+a*x(i-d,1);
    y(i,2) = x(i)+a*x(i-d,2);
end
subplot(2,1,1);
plot(x(:,1));grid on
title('Исходный сигнал')
subplot(2,1,2);
plot(y(:,1));grid on
title('Исходный сигнал с эхо')
