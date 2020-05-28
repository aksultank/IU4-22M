clear;

fs = 1;
ts = 0: 1/fs : 30-1/fs;

x1 = cos(2*pi*0.1*ts);
x2 = [x1 x1];
x3 = [x1 x1 x1];

N1 = length(x1);
N2 = length(x2);
N3 = length(x3);

X1 = abs(fft(x1));
X2 = abs(fft(x2));
X3 = abs(fft(x3));

figure;
subplot(3,2,1);
plot(x1), title('1 repeatable (3 periods)');
axis([0 90 -1 1]); grid on;
subplot(3,2,3);
plot(x2), title('2 repeatable (6 periods)');
axis([0 90 -1 1]); grid on;
subplot(3,2,5);
plot(x3), title('3 repeatable (9 periods)');
axis([0 90 -1 1]); grid on;

F1 = (0:N1-1)*fs/N1;
F2 = (0:N2-1)*fs/N2;
F3 = (0:N3-1)*fs/N3;

subplot(3,2,2);
plot(F1,X1,'-x'),axis([0 1 0 50]); grid on;
subplot(3,2,4);
plot(F2,X2,'-x'),axis([0 1 0 50]); grid on;
subplot(3,2,6);
plot(F3,X3,'-x'),axis([0 1 0 50]); grid on;