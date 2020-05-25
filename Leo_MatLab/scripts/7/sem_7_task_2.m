clear, clc, close all;

fs = 200;
freq_part_cnt = 5;

fs1 = 3;
fs2 = 4;
fs3 = 5;
fs4 = 7;
fs5 = 12;

ts1 = 0: 1/fs : 3-1/fs;
len_ts1 = length(ts1);
data(1:len_ts1)...
    = sin(2*pi*fs1*ts1);

ts2 = 1: 1/fs : 8-1/fs;
len_ts2 = length(ts2);
data(len_ts1+1:len_ts1+len_ts2)...
    = sin(2*pi*fs2*ts2);

ts3 = 6: 1/fs : 10-1/fs;
len_ts3 = length(ts3);
data(len_ts1+len_ts2+1:len_ts1+len_ts2+len_ts3)...
    = sin(2*pi*fs3*ts3);

ts4 = 11: 1/fs : 12-1/fs;
len_ts4 = length(ts4);
data(len_ts1+len_ts2+len_ts3+1:len_ts1+len_ts2+len_ts3+len_ts4)...
    = sin(2*pi*fs4*ts4);

ts5 = 11: 1/fs : 14-1/fs;
len_ts5 = length(ts5);
data(len_ts1+len_ts2+len_ts3+len_ts4+1:len_ts1+len_ts2+len_ts3...
    +len_ts4+len_ts5) = sin(2*pi*fs5*ts5);

ts = [ts1 ts2 ts3 ts4 ts5];
n = length(ts);

figure('Name','Spectral analysis, signal & FFT','units','normalized',...
    'outerposition',[0 0 1 1]);

subplot(2,1,1);
plot(ts, data);
grid minor;
title('Signal with 5 freqs & overlap');
xlabel('Time');
ylabel('Amplitude');

data_spectr = 2*abs(fft(data))/n;
fs_spectr = 0 : fs/n : fs-fs/n;

subplot(2,1,2);
stem(fs_spectr(1:length(fs_spectr)/5), data_spectr(1:length(fs_spectr)/5));
grid minor;
title('Spectr of signal');
xlabel('Frequency');
ylabel('Amplitude');

fb = cwtfilterbank('SignalLength',length(data),'SamplingFrequency',fs,...
    'FrequencyLimits',[fs1 fs5]);

figure('Name','Spectral analysis, continous wavelet transform with fb',...
    'units','normalized','outerposition',[0 0 1 1]);

cwt(data,'FilterBank',fb);
