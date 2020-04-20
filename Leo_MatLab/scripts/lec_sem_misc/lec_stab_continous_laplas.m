clear;

b = [1 2 -1];
a = [1 3 2];

omega = linspace(-2.5, 2.5);
sigma = linspace(-2.5, 0.5);

[sigmagrid, omegagrid] = meshgrid(sigma, omega);
sgrid = sigmagrid + 1i*omegagrid;
H = polyval(b, sgrid)./polyval(a, sgrid);

mesh(sigma, omega, abs(H));
xlabel('sigma');
ylabel('j_omega');
zlabel('|H(s)|');

Hs = tf(b,a);
iopzmap(Hs), grid on;

