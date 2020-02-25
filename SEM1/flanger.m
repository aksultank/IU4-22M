clear;
clear sound;
[x,fs] = audioread('Korg-01W-RosewoodGt-C3.wav');

N = length(x);
delay_max = round(2*fs);
delay_cnt = 0.8*fs;

delay1 = round(linspace(0,delay_max,delay_cnt)); 
delay2 = round(linspace(delay_max,0,delay_cnt));

delay = [delay1,delay2];

n_rep = round(N/length(delay));

delay = repmat(delay,1,n_rep+1);

y = zeros(1,N);
y = y';
for i = 1:N
    n = delay(i);
    if n>0
        y(i)=x(i)+x(n);
    else 
        y(i)=x(i);
    end
end

subplot(2,1,1);
plot(x); grid on;
axis('tight');
title('Sig IN');
%xlim([0 1000])

subplot(2,1,2);
plot(y); grid on;
axis('tight');
title('Sig out')
%xlim([0 1000]);
%{
subplot(3,1,3);
plot(y-x(:,1)); 
grid on;
axis('tight');
title('difference')
%}
sound(y,fs)
