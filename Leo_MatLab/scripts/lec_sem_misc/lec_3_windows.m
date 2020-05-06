clear;

fs = 32000;

ts = 0 : 1/fs : 0.05-1/fs;
N = length(ts);

f01 = 8000;
f02 = 8550;
f03 = 8750;

fp = 9170;
ap = 0.1;

x1 = sin(2*pi*f01*ts) + ap*sin(2*pi*fp*ts);
x2 = sin(2*pi*f02*ts) + ap*sin(2*pi*fp*ts);
x3 = sin(2*pi*f03*ts) + ap*sin(2*pi*fp*ts);

X1 = abs(fft(x1));
X2 = abs(fft(x2));
X3 = abs(fft(x3));

subplot(3,4,1);
plot(x1), grid on;
subplot(3,4,5);
plot(x2), grid on;
subplot(3,4,9);
plot(x3), grid on;

subplot(3,4,2);
stem(X1), grid on, title('8000Hz');
subplot(3,4,6);
stem(X2), grid on, title('8550Hz');
subplot(3,4,10);
stem(X3), grid on, title('8750Hz');

x1w = x1.*hanning(N)';
x2w = x2.*hanning(N)';
x3w = x3.*hanning(N)';

subplot(3,4,3);
plot(x1w), grid on;
subplot(3,4,7);
plot(x2w), grid on;
subplot(3,4,11);
plot(x3w), grid on;

X1w = abs(fft(x1w));
X2w = abs(fft(x2w));
X3w = abs(fft(x3w));

subplot(3,4,4);
stem(X1w), grid on, title('8000Hz with window');
subplot(3,4,8);
stem(X2w), grid on, title('8550Hz with window');
subplot(3,4,12);
stem(X3w), grid on, title('8750Hz with window');