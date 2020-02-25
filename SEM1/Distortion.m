clear;
clear sound;
[x, Fs] = audioread('Sound_19998_violin5.ogg');
val = 0.2;
subplot(3,1,1)
plot(x);
title('Исходный сигнал')
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
subplot(3,1,2);
plot(x); grid on
hold on;
plot(y);title('Исходный сигнал с искаженным')
hold off;
subplot(3,1,3);
plot(y); grid on; 
title('Искаженный сигнал')
ylim([min(x(:,1)) max(x(:,1))])
sound (y, Fs);