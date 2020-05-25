clear, clc, close all;

%% create initial signal with awgn
wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';
[x,fs] = audioread(wav_path,[900000,901000]);

figure('Name','Initial signal & with awgn','units','normalized',...
    'outerposition',[0 0 0.5 1]);

subplot(4,1,1); 
plot(x(:,1),'g'), grid minor, title('Initial x(:,1)');
subplot(4,1,3); 
plot(x(:,2),'g'), grid minor, title('Initial x(:,2)');

x(:,1) = awgn(x(:,1),25);
x(:,2) = awgn(x(:,2),25);

subplot(4,1,2); 
plot(x(:,1),'g'), grid minor, title('Initial & awgn x(:,1)');
subplot(4,1,4); 
plot(x(:,2),'g'), grid minor, title('Initial & awgn x(:,2)');

%% remove awgn from initial signal with wavelet

x(:,1) = awgn(x(:,1),25);
x(:,2) = awgn(x(:,2),25);

figure('Name','With awgn & removed with wavelet','units','normalized',...
    'outerposition',[0.5 0 0.5 1]);

subplot(4,1,1); 
plot(x(:,1),'g'), grid minor, title('Initial & awgn x(:,1)');
subplot(4,1,3); 
plot(x(:,2),'g'), grid minor, title('Initial & awgn x(:,2)');

x(:,1) = wdenoise(x(:,1),7,'Wavelet','db5','DenoisingMethod','Bayes');
x(:,2) = wdenoise(x(:,2),7,'Wavelet','db5','DenoisingMethod','Bayes');

subplot(4,1,2); 
plot(x(:,1),'g'), grid minor, title('Removed with wavelet x(:,1)');
subplot(4,1,4); 
plot(x(:,2),'g'), grid minor, title('Removed with wavelet x(:,2)');
