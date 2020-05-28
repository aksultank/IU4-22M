clear, clc, close all;

fs = 40000;
ts = 0 : 1/fs : 0.005-1/fs;

x = cos(2*pi*1000*ts);
y = sin(2*pi*1000*ts);

figure('Name','Figure 1','units','normalized',...
    'outerposition',[0 0.7 0.3 0.3]);

subplot(2,1,1);
plot(x), grid on, title('x[n]');
xlabel('time');
ylabel('amplitude');

subplot(2,1,2);
plot(x), grid on, hold on, title('x[n] & y[n]');
plot(y), grid on;
xlabel('time');
ylabel('amplitude');

figure('Name','Figure 2','units','normalized',...
    'outerposition',[0.3 0.7 0.3 0.3]);

subplot(2,2,1);
plot3(x,y,ts), grid on, title('analytical signal');
xlabel('imagine part');
ylabel('real part');
zlabel('time');

subplot(2,2,2);
plot(x,y), grid on, hold on, title('proection of x-y');
xlabel('real part');
ylabel('imagine part');

subplot(2,2,3);
plot(x,ts), grid on, hold on, title('proection x-z');
xlabel('real part');
ylabel('time');

subplot(2,2,4);
plot(y,ts), grid on, hold on, title('proection y-z');
xlabel('imagine part');
ylabel('time');
