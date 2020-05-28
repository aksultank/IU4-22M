clear;

fs = 80;
ts = 0: 1/fs : 3-1/fs;

f1 = 10;
f2 = 20;
f3 = 30;

x = sin(2*pi*f1*ts) +...
    sin(2*pi*f2*ts) +...
    sin(2*pi*f3*ts);

subplot(2,2,1);
plot(x); grid on;

subplot(2,2,2);
stem(abs(fft(x))); grid on;

t1 = 0: 1/fs : 1-1/fs;
t2 = 1: 1/fs : 2-1/fs;
t3 = 2: 1/fs : 3-1/fs;

l1 = length(t1);
l2 = length(t2);
l3 = length(t3);

x1(1:l1) = sin(2*pi*f1*t1);
x2(l1+1:l1+l2) = sin(2*pi*f2*t2);
x3(l1+l2+1:l1+l2+l3) = sin(2*pi*f3*t3);

subplot(2,2,3);
plot(x3); grid on;

subplot(2,2,4);
stem(abs(fft(x3))); grid on;

