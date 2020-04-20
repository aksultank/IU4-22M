clear;

fs = 1;
ts = 0: 1/fs : 30-1/fs;

x = cos(2*pi*0.1*ts);

N1 = 64;
N2 = 128;
N3 = 256;

X1 = abs(fft(x,N1));
X2 = abs(fft(x,N2));
X3 = abs(fft(x,N3));

F1 = (0:N1-1)*fs/N1;
F2 = (0:N2-1)*fs/N2;
F3 = (0:N3-1)*fs/N3;

subplot(3,1,1);
plot(F1,X1,'-x'),title('N=64'), grid on;
subplot(3,1,2);
plot(F2,X2,'-x'),title('N=128'), grid on;
subplot(3,1,3);
plot(F3,X3,'-x'),title('N=256'), grid on;