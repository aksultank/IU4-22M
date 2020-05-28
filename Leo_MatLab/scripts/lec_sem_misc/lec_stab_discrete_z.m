clear;

G = tf([0.1 10 5],[1 8 4 2]);
Gd = c2d(G,0.1);
C = tf([2 1],[2 3]);
Cd = c2d(C,0.1);
sys = feedback(Gd,Cd);

figure;
rlocus(sys), grid minor;

figure;
subplot(2,2,1);
sys1 = feedback(Gd,Cd);
step(sys1);
grid minor;
title('K=1');

subplot(2,2,2);
sys2 = feedback(Gd,Cd*10);
step(sys2);
grid minor;
title('K=10');

subplot(2,2,3);
sys3 = feedback(Gd,Cd*20);
step(sys3);
grid minor;
title('K=20');

subplot(2,2,4);
sys4 = feedback(Gd,Cd*25);
step(sys4);
grid minor;
title('K=25');
