clear;

fs = 400;
T = 5;
ts= 0:1/fs:T-1/fs;

f1 = 150;
f2 = 100;
f3 = 190;
f4 = 173;
f5 = 164;

% 5 freqs in signal
x0 = sin(2*pi*f1*ts)+sin(2*pi*f2*ts)+sin(2*pi*f3*ts)...
    +sin(2*pi*f4*ts)+sin(2*pi*f5*ts);
X0 = fft(x0);

figure('units','normalized','outerposition',[0 0 0.5 1]);
subplot(2,2,1);
plot(x0), grid minor, title('main signal');
subplot(2,2,2);
stem(abs(X0)), grid minor, title('fft of main signal');

% merged 5 signals
t1= 0 : 1/fs : 1-1/fs;
x(1:length(t1))=sin(2*pi*f1*t1);

t2= 1 : 1/fs : 2-1/fs;
x(length(t1) + 1 : ...
    length(t1) + length(t2))...
    = sin(2*pi*f2*t2);

t3= 2 : 1/fs : 3-1/fs;         
x((length(t1) + length(t2) + 1) : ...
    length(t1) + length(t2) + length(t3))...
    = sin(2*pi*f3*t3);

t4= 3 : 1/fs : 4-1/fs;         
x((length(t1) + length(t2) + length(t3) + 1) : ...
    length(t1) + length(t2) + length(t3) + length(t4))...
    = sin(2*pi*f4*t4);

t5= 4 : 1/fs : 5-1/fs;         
x((length(t1) + length(t2) + length(t3) + length(t4) + 1) : ...
    length(t1) + length(t2) + length(t3) + length(t4) + length(t5))...
    = sin(2*pi*f5*t5);

subplot(2,2,3);
plot(x), grid minor, title('merged signal');

X = fft(x);

subplot(2,2,4);
stem(abs(X)), grid minor, title('fft of merged signal');

[WX,freq] = wft(x,fs,'f0',0.2);

figure('units','normalized','outerposition',[0.5 0 0.5 1]);
srf = surf(ts, freq, abs(WX), 'FaceAlpha', 0.5);
colorbar;
set(srf, 'LineStyle', 'none');
xlabel('Time'); ylabel('Frequency'); zlabel('Amplitude');
