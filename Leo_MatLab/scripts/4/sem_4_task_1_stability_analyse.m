clear;

% create random continuous system
Gc = tf([1 5 6.8 5],[4 8.9 4]);
Cc = tf([7 7 3.2 4],[3 2 4]);
sys_c = feedback(Gc,Cc);

% create random discrete system
G_tmp = tf([3 7.6],[0.9 19]);
C_tmp = tf([6.8 9 7],[3 2.1 4]);
Gd = c2d(G_tmp,0.1);
Cd = c2d(C_tmp,0.1);
sys_d = feedback(Gd,Cd);

% stability analysis for continuous system by Laplace
figure('Name','Pole-zero maps & root locus','units','normalized',...
    'outerposition',[0 0 0.5 1]);

subplot(2,2,1);
iopzmap(sys_c), grid minor; % nulls - x; poles - o;
title('Pole-zero map of sys_c');
subplot(2,2,2);
rlocus(sys_c), grid minor; % nulls - x; poles - o;
title('Root locus of sys_c');

% stability analysis for discrete system by z-transform
subplot(2,2,3);
iopzmap(sys_d), grid minor; % nulls - o; poles - x;
title('Pole-zero map of sys_d');
subplot(2,2,4);
rlocus(sys_d), grid minor; % nulls - o; poles - x;
title('Root locus of sys_d');

% stability analysis for continuous & discrete system by Bode
figure('Name','Bode','units','normalized',...
    'outerposition',[0.5 0.5 0.5 0.5]);

subplot(1,2,1);
bode(sys_c), grid minor;
title('Bode diagram of sys_c');
subplot(1,2,2);
bode(sys_d), grid minor;
title('Bode diagram of sys_d');

% stability analysis for continuous & discrete system by Nyquist
figure('Name','Nyquist','units','normalized',...
    'outerposition',[0.5 0 0.5 0.5]);

subplot(1,2,1);
nyquist(sys_c), grid minor;
title('Nyquist diagram of sys_c');
subplot(1,2,2);
nyquist(sys_d), grid minor;
title('Nyquist diagram of sys_d');

%stability analysis for continuous & discrete system by Hurwitz

[~,den] = tfdata(sys_c);
den = cell2mat(den);
coeffVector = fliplr(den);
ceoffLength = length(coeffVector);
rhTableColumn = round(ceoffLength/2);
rhTable = zeros(ceoffLength,rhTableColumn);
rhTable(1,:) = coeffVector(1,1:2:ceoffLength);

if (rem(ceoffLength,2) ~= 0)
    rhTable(2,1:rhTableColumn - 1) = coeffVector(1,2:2:ceoffLength);
else
    rhTable(2,:) = coeffVector(1,2:2:ceoffLength);
end

epss = 0.01;

for i = 3:ceoffLength
    if rhTable(i-1,:) == 0
        order = (ceoffLength - i);
        cnt1 = 0;
        cnt2 = 1;
        for j = 1:rhTableColumn - 1
            rhTable(i-1,j) = (order - cnt1) * rhTable(i-2,cnt2);
            cnt2 = cnt2 + 1;
            cnt1 = cnt1 + 2;
        end
    end
    
    for j = 1:rhTableColumn - 1
        firstElemUpperRow = rhTable(i-1,1);
        rhTable(i,j) = ((rhTable(i-1,1) * rhTable(i-2,j+1)) - ....
            (rhTable(i-2,1) * rhTable(i-1,j+1))) / firstElemUpperRow;
    end
    if rhTable(i,1) == 0
        rhTable(i,1) = epss;
    end
end

unstablePoles = 0;

for i = 1:ceoffLength - 1
    if sign(rhTable(i,1)) * sign(rhTable(i+1,1)) == -1
        unstablePoles = unstablePoles + 1;
    end
end

fprintf('\n\rSYS_C Routh-Hurwitz Table:\n\r')
disp(rhTable);

if unstablePoles == 0
    fprintf('SYS_C STABLE SYSTEM...\n\r')
else
    fprintf('SYS_C UNSTABLE SYSTEM...\n\r')
end

[num,den] = tfdata(sys_d);
den = cell2mat(den);
coeffVector = fliplr(den);
ceoffLength = length(coeffVector);
rhTableColumn = round(ceoffLength/2);
rhTable = zeros(ceoffLength,rhTableColumn);
rhTable(1,:) = coeffVector(1,1:2:ceoffLength);

if (rem(ceoffLength,2) ~= 0)
    rhTable(2,1:rhTableColumn - 1) = coeffVector(1,2:2:ceoffLength);
else
    rhTable(2,:) = coeffVector(1,2:2:ceoffLength);
end

epss = 0.01;

for i = 3:ceoffLength
    if rhTable(i-1,:) == 0
        order = (ceoffLength - i);
        cnt1 = 0;
        cnt2 = 1;
        for j = 1:rhTableColumn - 1
            rhTable(i-1,j) = (order - cnt1) * rhTable(i-2,cnt2);
            cnt2 = cnt2 + 1;
            cnt1 = cnt1 + 2;
        end
    end
    
    for j = 1:rhTableColumn - 1
        firstElemUpperRow = rhTable(i-1,1);
        rhTable(i,j) = ((rhTable(i-1,1) * rhTable(i-2,j+1)) - ....
            (rhTable(i-2,1) * rhTable(i-1,j+1))) / firstElemUpperRow;
    end
    if rhTable(i,1) == 0
        rhTable(i,1) = epss;
    end
end

unstablePoles = 0;

for i = 1:ceoffLength - 1
    if sign(rhTable(i,1)) * sign(rhTable(i+1,1)) == -1
        unstablePoles = unstablePoles + 1;
    end
end

fprintf('\n\rSYS_D Routh-Hurwitz Table:\n\r')
disp(rhTable);

if unstablePoles == 0
    fprintf('SYS_D STABLE SYSTEM...\n\r')
else
    fprintf('SYS_D UNSTABLE SYSTEM...\n\r')
end

% impulse characteristics & reaction to Heaviside func with som diff K
figure('Name',...
    'Impulse characteristic & react to Heaviside func with K of sys_c',...
    'units','normalized',...
    'outerposition',[0 0 0.5 1]);

subplot(2,1,1);
impulse(sys_c), grid minor;
title('Impulse characteristic of sys_c');

K0 = 1; sys_c_tmp_0 = feedback(Gc,Cc*K0);
K1 = 1.05; sys_c_tmp_1 = feedback(Gc,Cc*K1);
K2 = 1.09; sys_c_tmp_2 = feedback(Gc,Cc*K2);
K3 = 1.12; sys_c_tmp_3 = feedback(Gc,Cc*K3);
K4 = 1.2; sys_c_tmp_4 = feedback(Gc,Cc*K4);

subplot(2,1,2);
step(sys_c_tmp_0,'b',...
    sys_c_tmp_1,'k',...
    sys_c_tmp_2,'r',...
    sys_c_tmp_3,'g',...
    sys_c_tmp_4,'y'), grid minor;
legend('K0 = 1','K1=1.05','K2=1.09','K3=1.12','K4=1.2');
title('Reaction of sys_c to Heaviside with some different K');

figure('Name',...
    'Impulse characteristic & react to Heaviside func with K of sys_d',...
    'units','normalized',...
    'outerposition',[0.5 0 0.5 1]);

subplot(2,1,1);
impulse(sys_d), grid minor;
title('Impulse characteristic of sys_d');

K0 = 1; sys_d_tmp_0 = feedback(Gd,Cd*K0);
K1 = 1.05; sys_d_tmp_1 = feedback(Gd,Cd*K1);
K2 = 1.09; sys_d_tmp_2 = feedback(Gd,Cd*K2);
K3 = 1.12; sys_d_tmp_3 = feedback(Gd,Cd*K3);
K4 = 1.2; sys_d_tmp_4 = feedback(Gd,Cd*K4);

subplot(2,1,2);
step(sys_d_tmp_0,'b',...
    sys_d_tmp_1,'k',...
    sys_d_tmp_2,'r',...
    sys_d_tmp_3,'g',...
    sys_d_tmp_4,'y'), grid minor;
legend('K0 = 1','K1=1.05','K2=1.09','K3=1.12','K4=1.2');
title('Reaction of sys_d to Heaviside with some different K');
