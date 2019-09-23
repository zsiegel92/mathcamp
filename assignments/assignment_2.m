A=30;
K = 20;
ttheta = 1/3;
r=1;
w=10;

diff = @(l) w - (1-ttheta)*A*l.^(-ttheta)*K.^ttheta;
Pifun = @(l) A*K.^(ttheta)*l.^(1-ttheta) - r*K - w*l;

f = figure('visible','off');
plot(1:1000,Pifun(1:1000));
xlabel("l");
ylabel("\Pi (l)");
title("Profit vs Labor (all else fixed)")
saveas(f,'shared/Pi_vs_l','png');

plot(1:1000,diff(1:1000));
xlabel("l");
ylabel("w - (1-\theta)Al^{-\theta}K^{\theta}");
title("Difference (for FOC) vs Labor (all else fixed)")
saveas(f,'shared/Difference_vs_l','png');

lzero = fzero(diff,150,optimset('Display','off'));
lzero2 = fsolve(diff,150,optimset('Display','off'));
lzero3 = fminunc(@(l) -Pifun(l),150);
disp("The three methods of maximizing profit found l = : " + num2str(lzero) + ", " + num2str(lzero2) + ", and " + num2str(lzero3) + ".");

bestLabor = @(W) fzero(@(l) W - (1-ttheta)*A*l.^(-ttheta)*K.^ttheta,100,optimset('Display','off'));
bestProfit = @(W) Pifun(fzero(@(l) W - (1-ttheta)*A*l.^(-ttheta)*K.^ttheta,100,optimset('Display','off')));


plot(1:100,arrayfun(bestLabor,1:100));
xlabel("w");
ylabel("Optimal Labor");
title("Optimal Labor vs Wage")
saveas(f,'shared/Optimal_Labor','png');

plot(1:100,arrayfun(bestProfit,1:100));
xlabel("w");
ylabel("Optimal Profit");
title("Profit at Optimal Labor vs Wage")
saveas(f,'shared/Optimal_Profit','png');
