clear, clc, close all;

fs = 500;

fs1 = 3;
fs2 = 4;
fs3 = 5;
fs4 = 7;
fs5 = 12;

ts_tmp = 0: 1/fs : 1-1/fs;
len_ts_unit = length(ts_tmp);
data(0*len_ts_unit+1:14*len_ts_unit) = 0;
ts = 0: 1/fs : 14-1/fs;
n = length(ts);

ts1 = 0: 1/fs : 3-1/fs;
data(0*len_ts_unit+1:3*len_ts_unit)...
    = data(0*len_ts_unit+1:3*len_ts_unit) + sin(2*pi*fs1*ts1);

ts2 = 1: 1/fs : 8-1/fs;
data(1*len_ts_unit+1:8*len_ts_unit)...
    = data(1*len_ts_unit+1:8*len_ts_unit) + sin(2*pi*fs2*ts2);

ts3 = 6: 1/fs : 10-1/fs;
data(6*len_ts_unit+1:10*len_ts_unit)...
    = data(6*len_ts_unit+1:10*len_ts_unit) + sin(2*pi*fs3*ts3);

ts4 = 11: 1/fs : 12-1/fs;
data(11*len_ts_unit+1:12*len_ts_unit)...
    = data(11*len_ts_unit+1:12*len_ts_unit) + sin(2*pi*fs4*ts4);

ts5 = 11: 1/fs : 14-1/fs;
data(11*len_ts_unit+1:14*len_ts_unit)...
    = data(11*len_ts_unit+1:14*len_ts_unit) + sin(2*pi*fs5*ts5);

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
stem(fs_spectr(1:length(fs_spectr)/10), data_spectr(1:length(fs_spectr)/10));
grid minor;
title('Spectr of signal');
xlabel('Frequency');
ylabel('Amplitude');

fb = cwtfilterbank('SignalLength',n,'SamplingFrequency',fs,...
    'FrequencyLimits',[fs1 fs5]);

figure('Name','Spectral analysis, continous wavelet transform with fb',...
    'units','normalized','outerposition',[0 0 1 1]);

cwt(data,'FilterBank',fb);
