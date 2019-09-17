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
plot(xvals,yvals)
