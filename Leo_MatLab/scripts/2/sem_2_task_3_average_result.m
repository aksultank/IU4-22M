clear;

fs = 460;   % freq
Ns = 47;    % number of fragments
ts = 0 : 1/fs : Ns*10-1/fs; % count sequence
N = length(ts);     % counts number

f1 = 130;
f2 = 156;
f3 = 219;

x = 0.3*sin(2*pi*f3*ts) + ...
    0.25*sin(2*pi*(f2-47)*ts) + ...
    0.3*sin(2*pi*f1*ts) + ...
    0.15*sin(2*pi*(f1+11)*ts) + ...
    0.7*sin(2*pi*(f3+24)*ts) + ...
    4*randn(size(ts)) + ...
    pinknoise(N);

N1 = round(length(ts)/Ns);
x1 = x(1:N1);

F = (0 : N1-1)*fs/N1;

X = abs(fft(x1))*2/N1;

figure('units','normalized','outerposition',[0.5 0 0.5 1]);
subplot(4,2,1);
plot(x1), grid minor, title('main signal');
subplot(4,2,2);
plot(F,X), grid minor, title('fft of main signal');

xw = x1.*parzenwin(N1)';

subplot(4,2,3);
plot(xw), grid minor, title('with parzenwindow');

Xw = abs(fft(xw))*2/N1;

subplot(4,2,4);
plot(F,Xw), grid minor, title('fft with parzenwindow');

xw = x1.*triang(N1)';

subplot(4,2,5);
plot(xw), grid minor, title('with triang');

Xw = abs(fft(xw))*2/N1;

subplot(4,2,6);
plot(F,Xw), grid minor, title('fft with triang');

xw = x1.*flattopwin(N1)';

subplot(4,2,7);
plot(xw), grid minor, title('with flattopwindow');

Xw = abs(fft(xw))*2/N1;

subplot(4,2,8);
plot(F,Xw), grid minor, title('fft with flattopwindow');

Nseg = 1000;
Xsum1 = zeros(1,Nseg);
Xsum2 = zeros(1,Nseg);
Xsum3 = zeros(1,Nseg);
for i =1 : N/Nseg
    
    xtmp0 = x((i-1)*Nseg+1 : (i-1)*Nseg+Nseg);
    
    xtmp1 = xtmp0.* parzenwin(Nseg)';
    Xsum1 = Xsum1 + abs(fft(xtmp1))*2/Nseg;
    
    xtmp2 = xtmp0.* triang(Nseg)';
    Xsum2 = Xsum2 + abs(fft(xtmp2))*2/Nseg;
    
    xtmp3 = xtmp0.* flattopwin(Nseg)';
    Xsum3 = Xsum3 + abs(fft(xtmp3))*2/Nseg;
    
end

Xsum1 = Xsum1/(N/Nseg);
fsum1 = (0 : Nseg-1)*fs/Nseg;

Xsum2 = Xsum2/(N/Nseg);
fsum2 = (0 : Nseg-1)*fs/Nseg;

Xsum3 = Xsum3/(N/Nseg);
fsum3 = (0 : Nseg-1)*fs/Nseg;

figure('units','normalized','outerposition',[0 0 0.5 1]);
subplot(3,1,1);
plot(fsum1(1:Nseg/2),Xsum1(1:Nseg/2)), grid minor;
title('averaged fft with parzenwindow');
subplot(3,1,2);
plot(fsum2(1:Nseg/2),Xsum2(1:Nseg/2)), grid minor;
title('averaged fft with triang');
subplot(3,1,3);
plot(fsum3(1:Nseg/2),Xsum3(1:Nseg/2)), grid minor;
title('averaged fft with flattopwindow');