clear, clc, close all;

fs = 40000;
ts = 0 : 1/fs : 0.005-1/fs;
n = length(ts);

x = cos(2*pi*1000*ts);

X = fft(x);

fp = 2:floor(n/2) + mod(n,2);
fn = ceil(n/2) + 1 + ~mod(n,2):n;

S(fn) = X(fn)*0;
S(fp) = X(fp)*2;

s = ifft(S);

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0 0.5 0.5 0.5]);

subplot(2,1,1);
plot(x), grid minor, title('Init signal x[n]');
xlabel('time');
ylabel('amplitude');

subplot(2,1,2);
plot(real(s)), grid minor, hold on;
plot(imag(s)), grid minor, title('Analytic signal s[n]');
xlabel('time');
ylabel('amplitude');
legend({'Real part';'Imag part'});
