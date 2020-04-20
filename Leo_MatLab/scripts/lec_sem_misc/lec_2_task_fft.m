clear;

fs = 8000;
ts = 0 : 1/fs : 0.001-1/fs;
N = length(ts);

x = sin(2*pi*1500*ts) + 0.5*sin(2*pi*2200*ts*3*pi/4);

plot(x);
grid minor;

%X = zeros(N,1);
% for m = 1:N
%     for n = 1:N
%         X(m) = X(m)+X(n)*(...
%         cos(2*pi*(m-1)*(n-1)/N)-1i*sin(2*pi*(n-1)*(m-1)/N)...
%         );
%     end
% end

X=fft(x);

figure;
subplot(2,1,1);
stem(real(X));
grid minor;
title('Действительная часть');

subplot(2,1,2);
stem(imag(X));
grid minor;
title('Мнимая часть');

figure;
subplot(2,1,1);
stem(abs(X));
grid minor;
title('Амплитуда');

subplot(2,1,2);
stem(angle(X)*180/pi);
grid minor;
title('Фаза');

Xm = 2*abs(X)/N;
F = (0:N-1)*fs/N;

figure;
stem(F,Xm);
grid minor;
title('Нормированная амплитуда и частота')