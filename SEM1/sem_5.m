clear;                                  %Очистка Workspace
clear sound; 
[src, fs] = audioread('Alesis-Fusion-Nylon-String-Guitar-C4.wav');
 
modifier=zeros(size(src));              %Обнуление массива
result=zeros(size(src));%Обнуление массива

for i=1:length(src)
    result(i,1)=src(i,1)*sin(i/3000);   %Модуляция исходного сигнала синусоидой
    result(i,2)=src(i,2)*sin(i/3000);
    modifier(i,1)=sin(i/2000);          %Модулирующий сигнал
end
 
subplot(3,1,1);
plot(src); grid on;                %Построение первого канала
title('Исходный сигнал');
subplot(3,1,2);
plot(modifier(:,1)); grid on;           %Построение модулирующего сигнала
title('Модулирующий сигнал');
subplot(3,1,3);
plot(result); grid on;             %Построение итогового сигнала
title('Итоговый сигнал');
sound(result,fs);
%sound(src,fs);
