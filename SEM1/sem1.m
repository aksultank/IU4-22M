clear;
f0 = 100;   %исходная частота 

fs = 150;   %частоты дискретизации
fs1 = 300;
fs2 = 2500;

T = 0.1;   %длительность сигнала

ts  = 0:1/fs:T; %массивы с временными отсчетами
ts1  = 0:1/fs1:T;
ts2  = 0:1/fs2:T;

x = sin(2*pi*f0*ts);    %формирование синусоидального сигнала
x1 = sin(2*pi*f0*ts1);
x2 = sin(2*pi*f0*ts2);

subplot(3,1,1);
plot(ts,x,'-bo','MarkerFaceColor','r','MarkerSize',3);
xlabel('Time');
ylabel('Amplitude');
title('fs=150');
grid on;

subplot(3,1,2);
plot(ts1,x1,'-go','MarkerFaceColor','k','MarkerSize',3);
xlabel('Time');
ylabel('Amplitude');
title('fs=300');
grid on;

subplot(3,1,3);
plot(ts2,x2,'or-','MarkerFaceColor','k','MarkerSize',3);
xlabel('Time');
ylabel('Amplitude');
title('fs=2500');
grid on;



