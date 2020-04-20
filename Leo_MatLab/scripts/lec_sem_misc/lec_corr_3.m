clear;

N = 256;
a = -1;
b = 1;

x = (a + (b-a) * rand(1, N));

[c,lags] = xcorr(x,'coeff');

subplot(2,1,1);
plot(x),grid minor, title('Random signal');
xlabel('Time stamps'), ylabel('x[n]');

subplot(2,1,2);
plot(lags,c), grid minor, title('ACF for random signal');
xlabel('Time offset, j'), ylabel('c[j]');