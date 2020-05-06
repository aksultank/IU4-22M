clear, clc, close all;

fs = 10000;
ts = 0 : 1/fs : 0.2-1/fs;
N = length(ts);

%% carrier frequency
fc = 1000;

%% modulation
M = 16;
Nd = 50;
bit_size = N/Nd;
data = randi([0 M-1],Nd,1);

% create complex numbers array
qdata = qammod(data, M);
% signal constellation
sc = scatterplot(qdata); grid on;
obj = findobj(sc.Children(1),'type','line');
set(obj,'MarkerSize',20);
qmod = repelem(qdata,bit_size).';

% create sin & cos signals
i = real(qmod).*cos(2*pi*fc*ts);
q = imag(qmod).*sin(2*pi*fc*ts);

% sum i & q, get signal for sending
y = i + q;

% add noise
y = awgn(y, 20);

figure;
subplot(3,1,1);
plot(real(qmod)), grid on;
title('Real part of signal');
xlabel('Time'), ylabel('Real');
subplot(3,1,2);
plot(imag(qmod)), grid on;
title('Imag part of signal');
xlabel('Time'), ylabel('Imag');
subplot(3,1,3);
plot(y), grid on;
title('Modulated signal');
xlabel('Time'), ylabel('Amplitude');

%% Demodulation

io = 2*y.*cos(2*pi*fc*ts);
qo = 2*y.*sin(2*pi*fc*ts);

% apply LP - filter for removing carrier & multiple on 2
fltr = flm4;
iof = round(conv(fltr.Numerator,io));
qof = round(conv(fltr.Numerator,qo));

figure;
subplot(2,1,1);
plot(iof), grid on;
title('SynPhase part of demodulated signal after LP-filter');
subplot(2,1,2);
plot(qof), grid on;
title('Quadrature part of demodulated signal after LP-filter');

%% cmp results
%create complex signal after filter
of = complex(iof,qof);

% get values from array with step
% step is period of data sequencing
% and given the delay of filters
fir_delay = round(length(fltr.Numerator)/2);
of_dec = of(fir_delay+round(bit_size/2) : bit_size : length(of)-fir_delay);

% cmp results
y = qamdemod(of_dec, M);

figure;
plot(data,'b-'), grid on, hold on;
plot(y,'x','LineWidth',2);
title('Cmp encoded send() & decoded received() data');
xlabel('Number of count'), ylabel('Value');
legend({'Sended data';'Received data'})
