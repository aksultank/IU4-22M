clear;

fs = 100;
ts = 0:1/fs:5-1/fs;

x1 = (square(2*pi*ts)+1)/2;
x2 = 2*(square(2*pi*ts+pi)+1)/2;

subplot(2,1,1);
plot(x1), grid minor;
xlabel('Time stamps, n'), ylabel('x1[n]');

subplot(2,1,2);
plot(x2), grid minor;
xlabel('Time stamps, n'), ylabel('x2[n]');

figure;
[r12,lags] = xcorr(x1,x2);

plot(lags,r12), grid minor;
xlabel('Time offset, j'), ylabel('r_{12}[j]');

figure;
N = length(x1);
x2 = [x2 x2];

r12 = zeros(1,N);

for j=1:N-1
    r12(j) = sum(x1.*x2(j:j+N-1));
end

plot(r12), grid minor;
xlabel('Time offset, j'), ylabel('r_{12}[j]');

