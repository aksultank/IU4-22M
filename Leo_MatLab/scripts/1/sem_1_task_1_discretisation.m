clear;

xy_grid_max_1 = 20; % grid number settings
xy_grid_max_2 = 240;
xy_grid_max_3 = 500;

fs_base = 10;
fs0 = 15; % discretisation freq
fs1 = 180;
fs2 = 360;

T = 14; % signal duration

ts0  = 0:1/fs0:T; % array of signal time points
ts1  = 0:1/fs1:T;
ts2  = 0:1/fs2:T;

y = sin(2*pi*fs_base*ts0); % array of signal amp points
y1 = 2*sin(2*pi*fs_base*ts1);
y2 = 1/2*(sin(2*pi*fs_base*ts2));

plot(ts0(1:xy_grid_max_1),y(1:xy_grid_max_1),'-black+'...
,ts1(1:xy_grid_max_2),y1(1:xy_grid_max_2),'-red^'...
,ts2(1:xy_grid_max_3),y2(1:xy_grid_max_3),'-greeno');
grid minor;
xlabel('TIME');
ylabel('AMP');
title('SEM_1 TASK_1');