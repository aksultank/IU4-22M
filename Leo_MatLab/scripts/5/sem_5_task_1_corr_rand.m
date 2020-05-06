clear;

x1 = rand(1,200) - rand(1,200) + rand(1,200);
x2 = rand(1,200) + rand(1,200);

[c,lags] = xcorr(x1,x2,'normalized');

figure('Name','Random signals & CF','units','normalized',...
    'outerposition',[0 0 0.5 1]);

subplot(3,1,1);
plot(x1),grid minor, title('Random signal 1');
xlabel('Time stamps'), ylabel('x_1[n]');

subplot(3,1,2);
plot(x2),grid minor, title('Random signal 2');
xlabel('Time stamps'), ylabel('x_2[n]');

subplot(3,1,3);
plot(lags,c), grid minor, title('CF for random signals');
xlabel('Time offset, j'), ylabel('corr x_1 x_2[j]');