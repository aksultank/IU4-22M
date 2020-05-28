clear;

fs = 100;
ts = -20:1/fs:20-1/fs;
N = length(ts);

Hinf = zeros(N,1);
Hinf(N/2-750:N/2+749) = 1;

W = sinc(ts);

subplot(2,1,1);
plot(Hinf), grid minor, hold on;
plot(W);
xlabel('freq');
ylabel('amp');
title('filter AFC with infinite character Hinf(n) & window W(n)');

c = conv(Hinf, W);

subplot(2,1,2);
plot(c), grid minor;
xlabel('freq');
ylabel('amp');
title('convolution of Hinf(n) & W(n)');

