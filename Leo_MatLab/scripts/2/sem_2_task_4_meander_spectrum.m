clear;

figure_horizontal_count = 2;
N = 10;

fs = 30;
ts = -1:1/fs:1-1/fs;

nh = (1:N)*2-1;
y = sin(2*pi*nh'*ts);

Am = 4/pi./nh;

s1 = y.*Am';
s2 = cumsum(s1);

figure('units','normalized','outerposition',[0 0 1 1]);

for i = 1:N
        
    subplot(ceil(N/figure_horizontal_count),figure_horizontal_count*2,i*2-1);
    plot(ts, s2(i,:)), grid minor;
    title(['harmonics num: ' num2str(i)]);
    
    harm_fft = abs(fft(s2(i,:)));
    
    subplot(ceil(N/figure_horizontal_count),figure_horizontal_count*2,i*2);
    stem(harm_fft), grid minor;
    title(['spectrum of harmonics num: ' num2str(i)]);
    
end