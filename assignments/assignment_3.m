f = @(z) 3*z.^2 + 2*z;
F_analytic = @(z) z.^3 + z.^2;
% f = @(z) sin(z) + exp(-z^2);
% F = @(z) -cos(z) + (1/2)*sqrt(pi)*erf(z);

F_quadtx = @(z) quad(f,0,z);

disp("Difference on interval [0,1000] is " + num2str(F_analytic(1000) - F_quadtx(1000)));

n=10000;
interval = 0:pi/n:pi;

fig = figure('visible','off');
plot(interval,arrayfun(F_analytic,interval));
xlabel("x");
ylabel("\Integral_0^x f(z)dz");
title("Integral of f(x) = 3z^2 + 2z")
saveas(fig,'shared/Integral_fx','png');
