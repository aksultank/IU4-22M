clear;

fs = 32000;

ts = 0 : 1/fs : 0.05-1/fs;
N = length(ts);

f01 = 8000;
f02 = 8550;
f03 = 8750;

fp = 9170;
ap = 0.1;

% windows

x1 = sin(2*pi*f01*ts) + ap*sin(2*pi*fp*ts);
x2 = sin(2*pi*f02*ts) + ap*sin(2*pi*fp*ts);
x3 = sin(2*pi*f03*ts) + ap*sin(2*pi*fp*ts);

figure('units','normalized','outerposition',[0 1 1 0.5]);

subplot(3,4,1);
plot(x1), grid minor, title('x1 8000Hz');
subplot(3,4,5);
plot(x2), grid minor, title('x2 8550Hz');
subplot(3,4,9);
plot(x3), grid minor, title('x3 8750Hz');


X1 = abs(fft(x1));
X2 = abs(fft(x2));
X3 = abs(fft(x3));

subplot(3,4,2);
stem(X1), grid minor, title('fft x1');
subplot(3,4,6);
stem(X2), grid minor, title('fft x2');
subplot(3,4,10);
stem(X3), grid minor, title('fft x3');

% hanning

x1w = x1.*hanning(N)';
x2w = x2.*hanning(N)';
x3w = x3.*hanning(N)';

subplot(3,4,3);
plot(x1w), grid minor, title('x1 8000Hz with hanning window');
subplot(3,4,7);
plot(x2w), grid minor, title('x2 8550Hz with hanning window');
subplot(3,4,11);
plot(x3w), grid minor, title('x3 8750Hz with hanning window');

X1w = abs(fft(x1w));
X2w = abs(fft(x2w));
X3w = abs(fft(x3w));

subplot(3,4,4);
stem(X1w), grid minor, title('fft x1 with hanning window');
subplot(3,4,8);
stem(X2w), grid minor, title('fft x2 with hanning window');
subplot(3,4,12);
stem(X3w), grid minor, title('fft x3 with hanning window');

% bartlett

x1w = x1.*bartlett(N)';
x2w = x2.*bartlett(N)';
x3w = x3.*bartlett(N)';

figure('units','normalized','outerposition',[0.5 0.5 0.5 0.5]);
subplot(3,2,1);
plot(x1w), grid minor, title('x1 8000Hz with bartlett window');
subplot(3,2,3);
plot(x2w), grid minor, title('x2 8550Hz with bartlett window');
subplot(3,2,5);
plot(x3w), grid minor, title('x3 8750Hz with bartlett window');

X1w = abs(fft(x1w));
X2w = abs(fft(x2w));
X3w = abs(fft(x3w));

subplot(3,2,2);
stem(X1w), grid minor, title('fft x1 with bartlett window');
subplot(3,2,4);
stem(X2w), grid minor, title('fft x2 with bartlett window');
subplot(3,2,6);
stem(X3w), grid minor, title('fft x3 with bartlett window');

% parzenwin

x1w = x1.*parzenwin(N)';
x2w = x2.*parzenwin(N)';
x3w = x3.*parzenwin(N)';

figure('units','normalized','outerposition',[0.5 0.5 0.5 0.5]);
subplot(3,2,1);
plot(x1w), grid minor, title('x1 8000Hz with parzenwin window');
subplot(3,2,3);
plot(x2w), grid minor, title('x2 8550Hz with parzenwin window');
subplot(3,2,5);
plot(x3w), grid minor, title('x3 8750Hz with parzenwin window');

X1w = abs(fft(x1w));
X2w = abs(fft(x2w));
X3w = abs(fft(x3w));

subplot(3,2,2);
stem(X1w), grid minor, title('fft x1 with parzenwin window');
subplot(3,2,4);
stem(X2w), grid minor, title('fft x2 with parzenwin window');
subplot(3,2,6);
stem(X3w), grid minor, title('fft x3 with parzenwin window');

% triang

x1w = x1.*triang(N)';
x2w = x2.*triang(N)';
x3w = x3.*triang(N)';

figure('units','normalized','outerposition',[0.5 0.5 0.5 0.5]);
subplot(3,2,1);
plot(x1w), grid minor, title('x1 8000Hz with triang window');
subplot(3,2,3);
plot(x2w), grid minor, title('x2 8550Hz with triang window');
subplot(3,2,5);
plot(x3w), grid minor, title('x3 8750Hz with triang window');

X1w = abs(fft(x1w));
X2w = abs(fft(x2w));
X3w = abs(fft(x3w));

subplot(3,2,2);
stem(X1w), grid minor, title('fft x1 with triang window');
subplot(3,2,4);
stem(X2w), grid minor, title('fft x2 with triang window');
subplot(3,2,6);
stem(X3w), grid minor, title('fft x3 with triang window');

% trailing zeros

N1 = 64;
N2 = 128;
N3 = 256;

X1 = abs(fft(x3,N1));
X2 = abs(fft(x3,N2));
X3 = abs(fft(x3,N3));

F1 = (0:N1-1)*fs/N1;
F2 = (0:N2-1)*fs/N2;
F3 = (0:N3-1)*fs/N3;

figure('units','normalized','outerposition',[0 0 0.5 0.5]);

subplot(3,1,1);
plot(F1,X1,'-x'),title('N=64'), grid minor;
subplot(3,1,2);
plot(F2,X2,'-x'),title('N=128'), grid minor;
subplot(3,1,3);
plot(F3,X3,'-x'),title('N=256'), grid minor;

% trailing periods

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

figure('units','normalized','outerposition',[0.5 0 0.5 0.5]);

subplot(3,2,1);
plot(x1), title('1 repeatable (3 periods)');
axis([0 90 -1 1]); grid minor;
subplot(3,2,3);
plot(x2), title('2 repeatable (6 periods)');
axis([0 90 -1 1]); grid minor;
subplot(3,2,5);
plot(x3), title('3 repeatable (9 periods)');
axis([0 90 -1 1]); grid minor;

F1 = (0:N1-1)*fs/N1;
F2 = (0:N2-1)*fs/N2;
F3 = (0:N3-1)*fs/N3;

subplot(3,2,2);
plot(F1,X1,'-x'),axis([0 1 0 50]); grid minor;
subplot(3,2,4);
plot(F2,X2,'-x'),axis([0 1 0 50]); grid minor;
subplot(3,2,6);
plot(F3,X3,'-x'),axis([0 1 0 50]); grid minor;