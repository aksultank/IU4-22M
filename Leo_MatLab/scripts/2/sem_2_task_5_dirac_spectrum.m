clear;

fs = 100000;
ts = 0 : 1/fs : 0.001-1/fs;
N = length(ts);

% Dirac function
x = zeros(N,1);
x(1) = 1;

figure('units','normalized','outerposition',[0 0 1 1]);

subplot(4,3,2);
stem(x); grid minor;
title('initial figure');

% Fast FT
X_fft = zeros(N,1);

X_fft = fft(x);

subplot(4,3,4);
stem(real(X_fft)); grid minor;
title('Real part of FFT result');

subplot(4,3,6);
stem(imag(X_fft)); grid minor;
title('Imagine part of FFT result');

subplot(4,3,7);
stem(abs(X_fft)); grid minor;
title('Amplitude of MFT result');

subplot(4,3,9);
stem(angle(X_fft)*180/pi); grid minor;
title('Phase of MFT result');

Xm_fft = 2*abs(X_fft)/N;
F = (0:N-1)*fs/N;

subplot(4,3,11);
stem(F, Xm_fft); grid on;
title('Normalized amplitude & frequency');