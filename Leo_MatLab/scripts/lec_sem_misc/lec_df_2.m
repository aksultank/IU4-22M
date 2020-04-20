clear;

fs = 10;
ts = 0: 1/fs : 10-1/fs;
N = length(ts);

x = zeros(N,1);

x(5) = 1;

subplot(2,1,1);
stem(x), grid minor;
xlabel('time');
ylabel('amp');
title('Dirac func');

y = zeros(1,N+6);
for i = 6 : length(x)
    y(i) = (x(i-1)+x(i-2)+x(i-3)+x(i-4)+x(i-5))*1/5;
end

subplot(2,1,2);
stem(y(1:100)), grid minor;
xlabel('time');
ylabel('amp');
title('Impulse character');