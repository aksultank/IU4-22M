clear;

fs = 100;
ts = 0: 1/fs : 3-1/fs;
Np = length(ts);

f1 = 32;

% for random signal
a = -1;
b = 1;
Nr = Np;

% create & show periodical signal
xp = 0.1*sin(2*pi*f1*ts);

figure('Name','Signals & ACF','units','normalized',...
    'outerposition',[0 0 1 1]);

subplot(2,2,1);
plot(xp),grid minor, title('Periodical signal');
xlabel('Time'), ylabel('x_p');

[cp,lags_p] = xcorr(xp,'coeff');

subplot(2,2,3);
plot(lags_p/fs,cp), grid minor, title('ACF for periodical signal');
xlabel('Time offset'), ylabel('c_p');

% create & show random signal
xr = (a + (b - a) * rand(1,Nr));

subplot(2,2,2);
plot(xr),grid minor, title('Random signal');
xlabel('Time'), ylabel('x_r');

[cr,lags_r] = xcorr(xr,'coeff');

subplot(2,2,4);
plot(lags_r/fs,cr), grid minor, title('ACF for random signal');
xlabel('Time offset'), ylabel('c_r');

% find periods of periodical signal & show it
[pksh_p,lcsh_p] = findpeaks(cp);
short_p = mean(diff(lcsh_p))/fs;

[pklg_p,lclg_p] = findpeaks(cp, ...
    'MinPeakDistance',ceil(short_p)*fs,'MinPeakheight',0.3);
long_p = mean(diff(lclg_p))/fs;

subplot(2,2,3);
hold on
pks_p = plot(lags_p(lcsh_p)/fs,pksh_p,'or', ...
    lags_p(lclg_p)/fs,pklg_p+0.05,'vk');
hold off
legend(pks_p,['Period short: ' num2str(short_p)],...
    ['Period long: ' num2str(long_p)]);

% find periods of random signal & show it
[pksh_r,lcsh_r] = findpeaks(cr);
short_r = mean(diff(lcsh_r))/fs;

[pklg_r,lclg_r] = findpeaks(cr, ...
    'MinPeakDistance',ceil(short_r)*fs,'MinPeakheight',0.3);
long_r = mean(diff(lclg_r))/fs;

subplot(2,2,4);
hold on
pks_r = plot(lags_r(lcsh_r)/fs,pksh_r,'or', ...
    lags_r(lclg_r)/fs,pklg_r+0.05,'vk');
hold off
legend(pks_r,['Period short: ' num2str(short_r)],...
    ['Period long: ' num2str(long_r)]);

fprintf('\rPeriod in the graphic legend, see that...\n\r');
fprintf('If long period not determined -> non-periodical\n\r');
