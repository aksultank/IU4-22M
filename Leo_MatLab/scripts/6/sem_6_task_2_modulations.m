clear, clc, close all;

%% got init signal binary code for manipulations
wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';
bits_number_ask_psk = 60;
bits_number_qam = 300;
start_s = -5;
end_s = 5;

fs = 10000; % disc freq for time on graphics, etc...
ts = start_s : 1/fs : end_s-1/fs; % time stamp for time on graphics, etc...
ns = length(ts);

wav_path_id = fopen(wav_path,'r');
bin_code_ask_psk_msk = de2bi(fread(wav_path_id,ceil(bits_number_ask_psk/8)));
bin_code_qam = de2bi(fread(wav_path_id,ceil(bits_number_qam/8)));
fclose(wav_path_id);
bin_code_ask_psk_msk = bin_code_ask_psk_msk(:).'; % convert matrix to a row vector
bin_code_qam = bin_code_qam(:).'; % convert matrix to a row vector
bin_code_ask_psk_msk = bin_code_ask_psk_msk(1,1:bits_number_ask_psk);
bin_code_qam = bin_code_qam(1,1:bits_number_qam);
n_code = length(bin_code_ask_psk_msk); % counts of target signal
n_code_qam = length(bin_code_qam); % counts of target signal

bin_code_asc = bin_code_ask_psk_msk;
for i=1:n_code
    if bin_code_asc(1,i) == 0
        bin_code_asc(1,i) = 0.1;
    end
end

bin_code_8psk = bin_code_ask_psk_msk;
bin_8psk_len = 3*ceil(length(bin_code_8psk)/3);
bin_code_8psk(1,bin_8psk_len) = zeros();
code_8psk = bi2de(reshape(bin_code_8psk,ceil(length(bin_code_8psk)/3),3));
code_8psk_len = length(code_8psk(:,1));

bin_code_64qam = bin_code_qam;
bin_64qam_len = 6*ceil(length(bin_code_64qam)/6);
bin_code_64qam(1,bin_64qam_len) = zeros();
code_64qam = bi2de(reshape(bin_code_64qam,ceil(length(bin_code_64qam)/6),6));
code_64qam_len = length(code_64qam(:,1));

bin_code_msk = bin_code_ask_psk_msk;
bin_msk_len = length(bin_code_msk);
bin_code_msk(1,bin_msk_len) = zeros();
code_msk = bin_code_msk;
code_msk_len = length(code_msk);

%% carrier frequency
carrier_freq = 400;

%% ASK

% create fc & add white-noise for realism
fc = cos(2*pi*carrier_freq*ts);
fc = awgn(fc,25);

% modulation
br = 10;
% create scale count for reality viewing signal on figure
scale_counts = fs/carrier_freq;
bit_size = floor((carrier_freq/br)*scale_counts);

% create modulating signal
fm = zeros(1,ns);
for i=1:n_code
    for j=bit_size*(i-1)+1:bit_size*i
        fm(1,j) = bin_code_asc(1,i);
    end
end

y = fc.*fm;

figure('Name','ASK','units','normalized',...
    'outerposition',[0 0 0.45 1]);
subplot(3,1,1);
plot(ts,y,'LineWidth',0.5), grid minor, hold on;
plot(ts,fm,'LineWidth',2), grid minor, title('ASK modulation');
xlabel('Time'), ylabel('Amplitude');
legend({'Modulated signal';'Modulating signal'});

% signal constellation
scatterplot(hilbert(y(1,1:n_code*bit_size)),bit_size,round(bit_size/2)), grid minor;
title('ASK scatterplot');
set(2,'Name','ASK scatterplot','units','normalized',...
    'outerposition',[0.5 0 0.45 1]); % edit existing figure

% demodulation
h = hilbert(y);

figure(1);
subplot(3,1,2);
plot(ts,y,'LineWidth',0.5), grid minor, hold on;
plot(ts,abs(h),'LineWidth',2), grid minor, title('ASK demodulation');
xlabel('Time'), ylabel('Amplitude');
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

subplot(3,1,3);
plot(ts,dem,'LineWidth',2), grid on;
title('Code of demodulated signal');
xlabel('Time'), ylabel('Amplitude');
legend({'Code of signal'});

%% 8-PSK

% create fc for real (i) & imag (q) parts of signal
fci = cos(2*pi*carrier_freq*ts);
fcq = sin(2*pi*carrier_freq*ts);

% modulation
br = 1000;
% create scale count for reality viewing signal on figure
scale_counts = 8*(fs/carrier_freq);
bit_size = floor((carrier_freq/br)*scale_counts);

% create modulating signal
data = pskmod(code_8psk, 8);
mod = repelem(data,bit_size).';

% y = zeros(1,ns);
fmi = real(mod).*fci(1,1:code_8psk_len*bit_size);
fmq = imag(mod).*fcq(1,1:code_8psk_len*bit_size);
y = fmi + fmq;
y = awgn(y, 25);

figure('Name','8-PSK modulation','units','normalized',...
    'outerposition',[0 0 0.45 1]);
subplot(3,1,1), hold on;
plot(ts(1,1:code_8psk_len*bit_size),real(mod),'LineWidth',2), grid minor;
title('Real part of signal');
xlabel('Time'), ylabel('Real');
subplot(3,1,2);
plot(ts(1,1:code_8psk_len*bit_size),imag(mod),'LineWidth',2), grid minor;
title('Imag part of signal');
xlabel('Time'), ylabel('Imag');
subplot(3,1,3);
plot(ts(1,1:code_8psk_len*bit_size),y), grid on;
title('Modulated signal');
xlabel('Time'), ylabel('Amplitude');

% signal constellation
scatterplot(data), grid minor;
title('8-PSK scatterplot');
set(4,'Name','8-PSK scatterplot','units','normalized',...
    'outerposition',[0.5 0 0.45 1]); % edit existing figure

% demodulation
fmio = 8*y.*fci(1,1:code_8psk_len*bit_size);
fmqo = 8*y.*fcq(1,1:code_8psk_len*bit_size);

fltr = psk8_fir;
fmiof = round(conv(fltr.Numerator,fmio));
fmqof = round(conv(fltr.Numerator,fmqo));

figure('Name','8-PSK demodulation','units','normalized',...
    'outerposition',[0.5 0 0.45 1]);
subplot(3,1,1);
plot(fmiof), grid on;
title('InPhase part of demodulated signal after LP-filter');
subplot(3,1,2);
plot(fmqof), grid on;
title('Quadrature part of demodulated signal after LP-filter');

% cmp results
% create complex signal after filter
fmof = complex(fmiof,fmqof);

% get values from array with step
% step is period of data sequencing
% and given the delay of filters
fir_delay = round(length(fltr.Numerator)/2);
fmof_dec = fmof(fir_delay+round(bit_size/2) : bit_size...
    : length(fmof)-fir_delay);

% cmp results
z = pskdemod(fmof_dec, 8);

subplot(3,1,3);
plot(code_8psk,'g-'), grid on, hold on;
plot(z,'x','LineWidth',2);
title('CMP encoded send & decoded received data');
xlabel('Number of count'), ylabel('Value');
legend({'Sended data';'Received data'})


%% 64-QAM

% create fc for real (i) & imag (q) parts of signal
fci = cos(2*pi*carrier_freq*ts);
fcq = sin(2*pi*carrier_freq*ts);

% modulation
br = 1000;
% create scale count for reality viewing signal on figure
scale_counts = 8*(fs/carrier_freq);
bit_size = floor((carrier_freq/br)*scale_counts);

% create modulating signal
data = qammod(code_64qam, 64);
mod = repelem(data,bit_size).';

% y = zeros(1,ns);
fmi = real(mod).*fci(1,1:code_64qam_len*bit_size);
fmq = imag(mod).*fcq(1,1:code_64qam_len*bit_size);
y = fmi + fmq;
y = awgn(y, 25);

figure('Name','64-QAM modulation','units','normalized',...
    'outerposition',[0 0 0.45 1]);
subplot(3,1,1), hold on;
plot(ts(1,1:code_64qam_len*bit_size),real(mod),'LineWidth',2), grid minor;
title('Real part of signal');
xlabel('Time'), ylabel('Real');
subplot(3,1,2);
plot(ts(1,1:code_64qam_len*bit_size),imag(mod),'LineWidth',2), grid minor;
title('Imag part of signal');
xlabel('Time'), ylabel('Imag');
subplot(3,1,3);
plot(ts(1,1:code_64qam_len*bit_size),y), grid on;
title('Modulated signal');
xlabel('Time'), ylabel('Amplitude');

% signal constellation
scatterplot(data), grid minor;
title('64-QAM scatterplot');
set(7,'Name','64-QAM scatterplot','units','normalized',...
    'outerposition',[0.5 0 0.45 1]); % edit existing figure

% demodulation
fmio = 2*y.*fci(1,1:code_64qam_len*bit_size);
fmqo = 2*y.*fcq(1,1:code_64qam_len*bit_size);

fltr = qam64_fir;
fmiof = round(conv(fltr.Numerator,fmio));
fmqof = round(conv(fltr.Numerator,fmqo));

figure('Name','64-QAM demodulation','units','normalized',...
    'outerposition',[0.5 0 0.45 1]);
subplot(3,1,1);
plot(fmiof), grid on;
title('InPhase part of demodulated signal after LP-filter');
subplot(3,1,2);
plot(fmqof), grid on;
title('Quadrature part of demodulated signal after LP-filter');

% cmp results
% create complex signal after filter
fmof = complex(fmiof,fmqof);

% get values from array with step
% step is period of data sequencing
% and given the delay of filters
fir_delay = round(length(fltr.Numerator)/2);
fmof_dec = fmof(fir_delay+round(bit_size/2) : bit_size...
    : length(fmof)-fir_delay);

% cmp results
z = qamdemod(fmof_dec, 64);

subplot(3,1,3);
plot(code_64qam,'g-'), grid on, hold on;
plot(z,'x','LineWidth',2);
title('CMP encoded send & decoded received data');
xlabel('Number of count'), ylabel('Value');
legend({'Sended data';'Received data'})

%% MSK

% create fc for real (i) & imag (q) parts of signal
fci = cos(2*pi*carrier_freq*ts);
fcq = sin(2*pi*carrier_freq*ts);

% modulation
br = 1000;
% create scale count for reality viewing signal on figure
scale_counts = 8*(fs/carrier_freq);
bit_size = floor((carrier_freq/br)*scale_counts);

% create modulating signal
data = mskmod(code_msk, 1);
mod = repelem(data,bit_size);

% y = zeros(1,ns);
fmi = real(mod).*fci(1,1:code_msk_len*bit_size);
fmq = imag(mod).*fcq(1,1:code_msk_len*bit_size);
y = fmi + fmq;
y = awgn(y, 25);

figure('Name','MSK modulation','units','normalized',...
    'outerposition',[0 0 0.45 1]);
subplot(3,1,1), hold on;
plot(ts(1,1:code_msk_len*bit_size),real(mod),'LineWidth',2), grid minor;
title('Real part of signal');
xlabel('Time'), ylabel('Real');
subplot(3,1,2);
plot(ts(1,1:code_msk_len*bit_size),imag(mod),'LineWidth',2), grid minor;
title('Imag part of signal');
xlabel('Time'), ylabel('Imag');
subplot(3,1,3);
plot(ts(1,1:code_msk_len*bit_size),y), grid on;
title('Modulated signal');
xlabel('Time'), ylabel('Amplitude');

% signal constellation
scatterplot(data), grid minor;
title('MSK scatterplot');
set(10,'Name','MSK scatterplot','units','normalized',...
    'outerposition',[0.5 0 0.45 1]); % edit existing figure

% demodulation
fmio = 2*y.*fci(1,1:code_msk_len*bit_size);
fmqo = 2*y.*fcq(1,1:code_msk_len*bit_size);

fltr = msk_fir;
fmiof = round(conv(fltr.Numerator,fmio));
fmqof = round(conv(fltr.Numerator,fmqo));

figure('Name','MSK demodulation','units','normalized',...
    'outerposition',[0.5 0 0.45 1]);
subplot(3,1,1);
plot(fmiof), grid on;
title('InPhase part of demodulated signal after LP-filter');
subplot(3,1,2);
plot(fmqof), grid on;
title('Quadrature part of demodulated signal after LP-filter');

% cmp results
% create complex signal after filter
fmof = complex(fmiof,fmqof);

% get values from array with step
% step is period of data sequencing
% and given the delay of filters
fir_delay = round(length(fltr.Numerator)/2);
fmof_dec = fmof(fir_delay+round(bit_size/2) : bit_size...
    : length(fmof)-fir_delay);

% cmp results
z = mskdemod(fmof_dec, 1);

subplot(3,1,3);
plot(code_msk,'g-'), grid on, hold on;
plot(z,'x','LineWidth',2);
title('CMP encoded send & decoded received data');
xlabel('Number of count'), ylabel('Value');
legend({'Sended data';'Received data'})
