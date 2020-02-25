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

N = length(x);

delay_max = round(0.005*fs);
delay_cnt = 2*fs;

delay1 = round(linspace(0,delay_max,delay_cnt)); 
delay2 = round(linspace(delay_max,0,delay_cnt));

delay = [delay1,delay2];

n_rep = round(N/length(delay));

delay = repmat(delay,1,n_rep+1);

y = zeros(N,2);

for j = 1:2
    for i = 1:N
        n = delay(i);
        if n>0
            y(i,j) = x(i,j)+x(n,j);
        else 
            y(i,j) = x(i,j);
        end
    end
end

subplot(4,1,2); 
plot(y(:,1),'r');
grid minor;
subplot(4,1,4);
plot(y(:,2),'r');
grid minor;

audiowrite('../../Songs/out_sem1_task_3.wav',y,fs)

pause(7);
sound(y,fs);

pause(7);
clear sound;