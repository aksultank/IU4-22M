clear;

% part from one of first tasks, get an echo effect
wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';

[x,fs] = audioread(wav_path,[900000,1200000]);
% sound(x,fs);

figure('Name','Initial signal & with echo','units','normalized',...
    'outerposition',[0 0 0.5 1]);

subplot(4,1,1); 
plot(x(:,1),'g'), grid minor, title('Initial x(:,1)');
subplot(4,1,3); 
plot(x(:,2),'g'), grid minor, title('Initial x(:,2)');

y=zeros(size(x));

a = 0.8;
d = 25000;

for j = 1 : 2 % echo effect loop
    for i = d+1 : length(y(:,j))
        y(i,j) = x(i,j)+a*x(i-d,j);
    end
end

subplot(4,1,2); 
plot(y(:,1),'r'), grid minor, title('With echo x(:,1)');
subplot(4,1,4); 
plot(y(:,2),'r'), grid minor, title('With echo x(:,2)');
% now y is x with echo effect, lets go clear echo

% create ACF of signal (check bl, br - CUSTOM) & get peaks
[c_1,lags_1] = xcorr(y(:,1),'coeff');
[c_2,lags_2] = xcorr(y(:,2),'coeff');
c_1 = c_1(lags_1>0);
lags_1 = lags_1(lags_1>0);
c_2 = c_2(lags_2>0);
lags_2 = lags_2(lags_2>0);
Nc = length(c_1);
bl = int32(0*Nc)+1;
br = int32(0.335*Nc);

figure('Name','ACF of signal with echo','units','normalized',...
    'outerposition',[0.5 0 0.5 1]);

subplot(2,1,1);
plot(lags_1(bl:br)/fs,c_1(bl:br)), grid minor;
xlabel('Time offset'), ylabel('c_1');
findpeaks(c_1(bl:br),lags_1(bl:br),'MinPeakHeight', 0.3),...
    title('ACF for y(:,1)');
[peaks_1,dl_1] = findpeaks(c_1(bl:br),lags_1(bl:br),'MinPeakHeight', 0.3);

subplot(2,1,2);
plot(lags_2(bl:br)/fs,c_2(bl:br)), grid minor;
xlabel('Time offset'), ylabel('c_2');
findpeaks(c_2(bl:br),lags_2(bl:br),'MinPeakHeight', 0.3),...
    title('ACF for y(:,2)');
[peaks_2,dl_2] = findpeaks(c_2(bl:br),lags_2(bl:br),'MinPeakHeight', 0.3);

% IIR - filter for remove echo
clean_y_1 = filter(1,[1 zeros(1,dl_1-1) 0.5],y(:,1));
clean_y_2 = filter(1,[1 zeros(1,dl_2-1) 0.5],y(:,2));

% show signals without echo
figure('Name','Clean final signals','units','normalized',...
    'outerposition',[0.5 0 0.5 1]);

subplot(4,1,1);
plot(clean_y_1,'g'), grid minor, title('Clean y(:,1)');
subplot(4,1,3);
plot(clean_y_2,'g'), grid minor, title('Clean y(:,2)');

clear sound;