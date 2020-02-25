clear;

wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';

[x,fs] = audioread(wav_path,[900000,1200000]);
sound(x,fs);

subplot(4,1,1); 
plot(x(:,1),'g');
grid minor;
subplot(4,1,3); 
plot(x(:,2),'g');
grid minor;

y=zeros(size(x));

a = 0.8;
d = 25000;

for j = 1 : 2 % echo effect loop
    for i = d+1 : length(y(:,j))
        y(i,j) = x(i,j)+a*x(i-d,j);
    end
end
 
x(:,1) = x(:,2);
x(:,2) = 2*x(:,1); % amp pump

subplot(4,1,2); 
plot(y(:,1),'r');
grid minor;
subplot(4,1,4); 
plot(y(:,2),'r');
grid minor;

pause(7);
sound(y,fs);

pause(7);
clear sound;
% cmd in matlab terminal for safe your ears:
% clear sound;