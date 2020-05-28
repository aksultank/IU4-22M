clear, clc, close all;

N = 32;
n = -N/2:N/2-1;

h = 1./(pi*n).*(1-cos(pi*n));
h(N/2+1) = 0;

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0 0.5 0.5 0.5]);

stem(n,h), grid minor, title('Pulse char of Hilbert filter');
xlabel('n'), ylabel('h[n]');
xlim([-N/2 N/2-1]);

figure('Name','Figure 2','units','normalized',...
    'outerposition',[0.5 0.5 0.5 0.5]);

H = fft(h);
f = (-N/2:N/2-1)*1/N;

H = H.*exp(-1i*2*pi*f*N/2);

subplot(2,1,1);
plot(f,abs(H),'o-'), grid minor;
title('AFC of Hilbert filter');
xlabel('\omega/\pi');
ylabel('|H[\omega]|');

phases=[-90;-45;0;45;90];
subplot(2,1,2);
plot(f, angle(H)*180/pi, '-o'), grid minor;
title('PFC of Hilbert filter');
xlabel('\omega/\pi');
ylabel('\phi(\omega)');
set(gca, 'YTick', phases);
