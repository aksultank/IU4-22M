clear, clc, close all;

fs = 10000;
ts = 0 : 1/fs : 0.1-1/fs;
N = length(ts);

%% carrier params
fc = 500;
h = 4;
T = 10e-3;

f0 = fc + h/(2*T);
f1 = fc - h/(2*T);

%% moduling signal
% one-byte length in counts
n_for_bit = T*fs;
% coded sequence
code = [1 0 0 1 1 0 1 0 1 1];

% create modulating signal
fm = zeros(1,N);
for i=1:length(code)
    for j=n_for_bit*(i-1)+1:n_for_bit*i
        fm(j) = code(i);
    end
end

%% frequency manipulation
x0 = cos(2*pi*f0*ts);
x1 = cos(2*pi*f1*ts);

x = zeros(1,N);
for i = 1:N
    if fm(i) == 0
        x(i) = x0(i);
    else
        x(i) = x1(i);
    end
end

subplot(2,1,1);
plot(ts,x,'LineWidth',0.5), grid on, hold on;
plot(ts,fm,'LineWidth',2), grid on;
title('FSK modulation');
xlabel('Time'), ylabel('Amplitude');
legend({'Modulated signal';'Modulating signal'});

%% FSK demodulation
% multiple signal on carrier
y0 = x.*x0;
y1 = x.*x1;

figure;
subplot(2,1,1);
plot(ts, y0), grid on;
title('Modulated signal, multiple on f0');
xlabel('Time'), ylabel('Amplitude');
subplot(2,1,2);
plot(ts, y1), grid on;
title('Modulated signal, multiple on f1');
xlabel('Time'), ylabel('Amplitude');

y = y1 - y0;

% apply LP filter for removing carrier
fltr = flm5;
z = filter(fltr.Numerator,1,y);

figure;
subplot(2,1,1);
plot(ts,y), grid on;
title('Signal y=y0-y1');
xlabel('Time'), ylabel('Amplitude');
subplot(2,1,2);
plot(ts,z), grid on;
title('Same signal, but filtered with LP-filter');
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
title('FSK demodulation');
legend({'Modulated signal';'Demodulated signal'});
