alpha = 5; %y-intercept
beta = 10; %slope
n = 100;
min = 0.01;
max = 1;
xvals = min:(max-min)/n:max;
xvals = xvals';
n = length(xvals);
yvals = beta*xvals + alpha + randn(n,1);
yvals = yvals;
X = [ones(n,1),xvals];
OLS = inv((X')*X)*(X')*yvals;
% alpha_hat = OLS(1);
% beta_hat = OLS(2);
y_estimates = X*OLS;
plot(xvals,yvals,'b^',xvals,y_estimates,'r--')
title('Data Normally Distributed About a Line and OLS Trendline')
legend({'observed','predicted'},'Location','northwest')
