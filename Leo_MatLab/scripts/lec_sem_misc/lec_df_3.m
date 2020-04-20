clear;

fs = 1000;
ts = 0:1/fs:1-1/fs;
N = length(ts);

x = zeros(N,1);
x(1:200) = 1;

y = real(ifftshift(ifft(x)));

subplot(2,1,1);
plot(x), grid minor;
xlabel('freq');
ylabel('amp');
title('waited AFC, x(n)');

subplot(2,1,2);
plot(N/2-100:N/2+100-1,y(N/2-100:N/2+100-1)), grid minor;
xlabel('time');
ylabel('amp');
title('Part of result impulse character, y(n)');

a = zeros(N,1);
a(1) = 1;
figure;

Nf1 = 5;
af1 = filter(y(N/2-Nf1:N/2+Nf1-1).*hamming(Nf1*2),1,a);
subplot(2,2,1);
plot(abs(fft(af1))), grid minor;
xlabel('freq');
ylabel('amp');
title('filter AFC, N=10');

Nf2 = 10;
af2 = filter(y(N/2-Nf2:N/2+Nf2-1).*hamming(Nf2*2),1,a);
subplot(2,2,2);
plot(abs(fft(af2))), grid minor;
xlabel('freq');
ylabel('amp');
title('filter AFC, N=20');

Nf3 = 25;
af3 = filter(y(N/2-Nf3:N/2+Nf3-1).*hamming(Nf3*2),1,a);
subplot(2,2,3);
plot(abs(fft(af3))), grid minor;
xlabel('freq');
ylabel('amp');
title('filter AFC, N=50');

Nf4 = 50;
af4 = filter(y(N/2-Nf4:N/2+Nf4-1).*hamming(Nf4*2),1,a);
subplot(2,2,4);
plot(abs(fft(af4))), grid minor;
xlabel('freq');
ylabel('amp');
title('filter AFC, N=100');
