clear, clc, close all;

fs = 200;
T = 10;
ts = -T:1/fs:T-1/fs;

%% Morlet family
family_counter = 5;
disp = 0;
stretch = 1;
family_coeff = 1/sqrt(stretch);
family_arg = (ts - disp)/stretch;

figure('Name','Morlet family','units','normalized',...
    'outerposition',[0 0.5 0.5 0.5]);

for i = 1:family_counter
    disp = 0;
    stretch = i;
    family_coeff = 1/sqrt(stretch);
    family_arg = (ts - disp)/stretch;
    c = cos(5*family_arg);
    g = exp(-family_arg.^2/2);
    w = family_coeff*c.*g;
    plot(ts,w), hold on;
    grid minor;
end

%% Mexican hat family
family_counter = 5;
disp = 0;
stretch = 1;
family_coeff = 1/sqrt(stretch);
family_arg = (ts - disp)/stretch;

figure('Name','Mexican hat family','units','normalized',...
    'outerposition',[0.5 0.5 0.5 0.5]);

for i = 1:family_counter
    disp = 0;
    stretch = i;
    family_coeff = 1/sqrt(stretch);
    family_arg = (ts - disp)/stretch;
    c = 2/(sqrt(3)*pi^(1/4))*(1-family_arg.^2);
    g = exp(-family_arg.^2/2);
    w = family_coeff*c.*g;
    plot(ts,w), hold on;
    grid minor;
end

%% Haar family
family_counter = 5;
disp = 0;
stretch = 1;
family_coeff = 1/sqrt(stretch);
family_arg = (ts - disp)/stretch;

figure('Name','Haar family','units','normalized',...
    'outerposition',[0 0 0.5 0.5]);

for i = 1:family_counter
    disp = 0;
    stretch = i;
    family_coeff = 1/sqrt(stretch);
    family_arg = (ts - disp)/stretch;
    w = zeros(1,length(family_arg));
    w((family_arg >= 0) & (family_arg < 0.5)) = family_coeff*1;
    w((family_arg >= 0.5) & (family_arg < 1)) = family_coeff*(-1);
    plot(ts,w), hold on;
    grid minor;
end

%% Daubechies family
family_counter = 5;

figure('Name','Daubechies family','units','normalized',...
    'outerposition',[0.5 0 0.5 0.5]);

for i = 1:family_counter
    dbN = strcat('db',string(i));
    fb = dwtfilterbank('Wavelet',dbN,'SignalLength',length(ts),'Level',10,'SamplingFrequency',fs);
	[psiw, tw] = wavelets(fb);
    plot(ts, psiw(10,:)), hold on;
    grid minor;
end
