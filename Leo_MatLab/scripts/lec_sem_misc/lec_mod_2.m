clear, clc, close all;

fs = 10000;
ts = 0 : 1/fs : 0.2-1/fs;
N = length(ts);

%% carrier frequency
fc = cos(2*pi*250*ts);
fc = awgn(fc,30);

%% modulating signal
% one-byte length in counts
n_for_bit = 200;
% coded sequence
code = [1 -1 -1 1 1 -1 1 -1 1 1];

% create modulating signal
fm = zeros(1,N);
for i=1:length(code)
    for j=n_for_bit*(i-1)+1:n_for_bit*i
        fm(j) = code(i);
    end
end

%% phase manipulation (BPSK)
x = fc.*fm;

plot(ts,x,'LineWidth',0.5), grid on, hold on;
plot(ts,fm,'LineWidth',2), grid on;
title('BPSK modulation')
xlabel('Time'), ylabel('Amplitude')
legend({'Modulated signal';'Modulating signal'})

%% signal constellation
scatterplot(hilbert(x),n_for_bit,round(n_for_bit/2)), grid on

%% BPSK demodulation
% multiple signal on carrier
y = x.*fc;

% apply LP filter for removing carrier
fltr = flm2;
z = filter(fltr.Numerator,1,y);

figure;
subplot(2,1,1);
plot(ts,y), grid on;
title('Modulated signal, multiple on carrier');
xlabel('Time'), ylabel('Amplitude')
subplot(2,1,2);
plot(ts,z), grid on;
title('Same signal, but filtered with LP 100 Hz filter');
xlabel('Time'), ylabel('Amplitude');

% comparator
dem = zeros(1,length(z));
for i=1:length(z)
    if z(i)>=0.1
        dem(i) = 1;
    else
        dem(i) = 0;
    end
end

figure;
plot(ts,x,'LineWidth',0.5), grid on, hold on;
plot(ts,dem,'LineWidth',2), grid on;
xlabel('Time'), ylabel('Amplitude');
title('BPSK demodulation');
legend({'Modulated signal';'Demodulated signal'});
