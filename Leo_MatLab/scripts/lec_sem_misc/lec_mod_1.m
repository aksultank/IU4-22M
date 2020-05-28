clear, clc, close all;

fs = 10000;
ts = -0.1 : 1/fs : 0.1-1/fs;
N = length(ts);

%% carrier frequency
fc = cos(2*pi*500*ts);
fc = awgn(fc,30);

%% modulating signal
% one-byte length in counts
n_for_bit = 200;
% coded sequence
code = [1 0.1 0.1 1 1 0.1 1 0.1 1 1];

% create modulating signal
fm = zeros(1,N);
for i=1:length(code)
    for j=n_for_bit*(i-1)+1:n_for_bit*i
        fm(j) = code(i);
    end
end

%% amplitude manipulation
x = fc.*fm;

plot(ts,x,'LineWidth',0.5), grid on, hold on
plot(ts,fm,'LineWidth',2), grid on
title('ASK modulation')
xlabel('Time'), ylabel('Amplitude')
legend({'Modulated signal';'Modulating signal'})

%% signal constellation
scatterplot(hilbert(x),n_for_bit,round(n_for_bit/2)), grid on

%% amplitude demodulation
% Hilbert transform
h  = hilbert(x);

figure;
subplot(2,1,1);
plot(ts,x,'LineWidth',0.5), grid on, hold on;
plot(ts,abs(h),'LineWidth',2), grid on;
title('ASK demodulation');
xlabel('time'), ylabel('amplitude');
legend({'Modulated signal';'Demodulated signal'});

% comparator
dem = zeros(1,length(h));
for i=1:length(h)
    if abs(h(i))>=0.5
        dem(i) = 1;
    else
        dem(i) = 0;
    end
end

subplot(2,1,2);
plot(ts,dem,'LineWidth',2), grid on;
title('Code of demodulated signal');
xlabel('time'), ylabel('amplitude');

