clear;

fs = 8000;
ts = 0 : 1/fs : 0.001-1/fs;
N = length(ts);

x = sin(2*pi*1700*ts) + 0.5*sin(2*pi*3150*ts+3*pi/4);

figure('units','normalized','outerposition',[0 0 1 1]);

subplot(4,5,3);
plot(x); grid minor;
title('initial figure');

% Manual FT
X_mft = zeros(N,1);

for m = 1:N
    for n = 1:N
        X_mft(m) = X_mft(m)+...
            x(n)*(cos(2*pi*(n-1)*(m-1)/N)...
            -1i*sin(2*pi*(n-1)*(m-1)/N));
    end
end

subplot(4,5,6);
stem(real(X_mft)); grid minor;
title('Real part of MFT result');

subplot(4,5,7);
stem(imag(X_mft)); grid minor;
title('Imagine part of MFT result');

subplot(4,5,11);
stem(abs(X_mft)); grid minor;
title('Amplitude of MFT result');

subplot(4,5,12);
stem(angle(X_mft)*180/pi); grid minor;
title('Phase of MFT result');

Xm_mft = 2*abs(X_mft)/N;
F = (0:N-1)*fs/N;

subplot(4,5,16);
stem(F, Xm_mft); grid on;
title('Normalized amplitude & frequency');

% Fast FT
X_fft = zeros(N,1);

X_fft = fft(x);

subplot(4,5,9);
stem(real(X_fft)); grid minor;
title('Real part of FFT result');

subplot(4,5,10);
stem(imag(X_fft)); grid minor;
title('Imagine part of FFT result');

subplot(4,5,14);
stem(abs(X_fft)); grid minor;
title('Amplitude of FFT result');

subplot(4,5,15);
stem(angle(X_fft)*180/pi); grid minor;
title('Phase of FFT result');

Xm_fft = 2*abs(X_fft)/N;
F = (0:N-1)*fs/N;

subplot(4,5,19);
stem(F, Xm_fft); grid on;
title('Normalized amplitude & frequency');