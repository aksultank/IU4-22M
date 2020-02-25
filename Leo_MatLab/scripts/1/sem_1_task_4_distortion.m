clear;

xy_grid_max = 10000;
wav_path = '../../Songs/Red_alert_3_USSR_anthem.wav';

[x,fs] = audioread(wav_path,[900000,1200000]);
sound(x,fs);

subplot(4,1,1); 
plot(x(1:xy_grid_max,1),'g');
grid minor;
subplot(4,1,3); 
plot(x(1:xy_grid_max,2),'g');
grid minor;

val = 0.15;

y = x;

for i = 1:length(x)
    if y(i,1) > val
        y(i,1) = val;
    end
    if y(i,1) < -val
        y(i,1) = -val;
    end
    if y(i,2) > val
        y(i,2) = val;
    end
    if y(i,2) < -val
        y(i,2) = -val;
    end
end

subplot(4,1,2); 
plot(y(1:xy_grid_max,1),'r');
grid minor;
subplot(4,1,4);
plot(y(1:xy_grid_max,2),'r');
grid minor;

audiowrite('../../Songs/out_sem1_task_4.wav',y,fs)

pause(7);
sound(y,fs);

pause(7);
clear sound;