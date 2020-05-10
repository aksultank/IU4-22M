clear;

wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';

[x,fs] = audioread(wav_path,[900000,902500]);
sound(x,fs);
n = length(x);

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0 0.25 0.5 0.5]);

subplot(2,1,1); 
plot(x(:,1),'g');
grid minor;
subplot(2,1,2); 
plot(x(:,2),'g');
grid minor;

% now lets create analytic signal from song
% with FFT, not hilbert

% calc fft
X = fft(x);

% find pos & neg freq indexes
fp = 2:floor(n/2) + mod(n,2);
fn = ceil(n/2) + 1 + ~mod(n,2):n;

% mul on zero elements with neg freq
% mul on 2 elements with pos freq
S = zeros(length(fp)+length(fn),2);

% we work with two channels, because input is .wav sound signal
for i = 1:2
    S(fn,i) = X(fn,i)*0;
    S(fp,i) = X(fp,i)*2;
end

% calc reverse fft
s = zeros(length(S),2);
for i = 1:2
    s(:,i) = ifft(S(:,i));
end

figure('Name','Figure 2','units','normalized',...
    'outerposition',[0.5 0.5 0.5 0.5]);
subplot(1,1,1);
plot(real(s(:,1))), grid minor, hold on;
plot(imag(s(:,1))), grid minor, title('Analytic signal s[n][1]');
xlabel('time');
ylabel('amplitude');
legend({'Real part';'Imag part'});

figure('Name','Figure 3','units','normalized',...
    'outerposition',[0.5 0 0.5 0.5]);
subplot(1,1,1);
plot(real(s(:,2))), grid minor, hold on;
plot(imag(s(:,2))), grid minor, title('Analytic signal s[n][2]');
xlabel('time');
ylabel('amplitude');
legend({'Real part';'Imag part'});

pause(1);
clear sound;
