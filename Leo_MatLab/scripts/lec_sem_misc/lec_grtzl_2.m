clear, clc, close all;

%% create signal from two harmonics
fs = 8000;
ts = 0 : 1/fs : 0.001-1/fs;
N = length(ts);

x = sin(2*pi*1000*ts) + 0.5*sin(2*pi*2000*ts+3*pi/4);

S = 2*abs(fft(x))/N;
f = 0 : fs/N : fs-fs/N;
stem(f,S), grid on, title('FFT of source signal');
xlabel('Frequency'), ylabel('Amplitude');

%% Calc around one count of DFT
X = 0;
m = 2;
for n = 1 : N
    X = X + x(n)*(cos(2*pi*(n-1)*m/N)-1i*sin(2*pi*(n-1)*m/N));
end

X = 2*abs(X)/N;

% view result
disp("Calc around one count of DFT:");
disp(X);

%% Goertzel algorithm
fg = 2000;
m = fg/fs*N+1;

u1 = 0;
u2 = 0;
w = 2*pi*(m-1)/N;
for n = 1:N
    u0 = 2*cos(w)*u1-u2+x(n);
    u2 = u1;
    u1 = u0;
end
y = u0 - exp(-1i*w)*u2;

Y = 2*abs(y)/N;
disp("Amplitude of frequency part fg:");
disp(Y);

H = goertzel(x,m);
H = 2*abs(H)/N;
disp("Result of standard MatLan goertzel func:");
disp(H);