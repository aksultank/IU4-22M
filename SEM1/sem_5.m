clear;                                  %������� Workspace
clear sound; 
[src, fs] = audioread('Alesis-Fusion-Nylon-String-Guitar-C4.wav');
 
modifier=zeros(size(src));              %��������� �������
result=zeros(size(src));%��������� �������

for i=1:length(src)
    result(i,1)=src(i,1)*sin(i/3000);   %��������� ��������� ������� ����������
    result(i,2)=src(i,2)*sin(i/3000);
    modifier(i,1)=sin(i/2000);          %������������ ������
end
 
subplot(3,1,1);
plot(src); grid on;                %���������� ������� ������
title('�������� ������');
subplot(3,1,2);
plot(modifier(:,1)); grid on;           %���������� ������������� �������
title('������������ ������');
subplot(3,1,3);
plot(result); grid on;             %���������� ��������� �������
title('�������� ������');
sound(result,fs);
%sound(src,fs);
