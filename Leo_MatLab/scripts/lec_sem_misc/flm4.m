function Hd = flm4
%FLM4 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.8 and DSP System Toolbox 9.10.
% Generated on: 06-May-2020 04:06:53

% Equiripple Lowpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 10000;  % Sampling Frequency

Fpass = 100;             % Passband Frequency
Fstop = 500;             % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.01;            % Stopband Attenuation
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]
