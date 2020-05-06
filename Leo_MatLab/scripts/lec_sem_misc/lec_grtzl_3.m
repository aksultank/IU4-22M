clear, clc, close all;

fs = 8000;
ts = 0 : 1/fs : 0.005-1/fs;
N = length(ts);

fg = 2000;
m = fg/fs*N+1;

y = zeros(1,fs/2);
% Goertzel filter
for k = 1:fs/2
    x = sin(2*pi*k*ts);
    y(k) = goertzel(x,m);
end

% receive array of amp & freq
Y = 2*abs(y)/N;
f = 1:fs/2;

% graph
plot(f,Y), grid on;
title('AFC of Goertzel filter with resonance frequency 2 kHz');
xlabel('Frequency'), ylabel('Amplitude');
