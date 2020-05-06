clear, clc, close all;

M1 = 4;
data1 = randi([0 M1-1],1000,1);

txSig = pskmod(data1, M1, pi/M1);
rxSig = awgn(txSig, 17);

scatterplot(rxSig), grid on;

M2 = 8;
data2 = randi([0 M2-1],1000,1);
txSig = pskmod(data2, M2);
rxSig = awgn(txSig, 17);

scatterplot(rxSig), grid on;
