# import numpy
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider
from numpy.random import normal as randn
from numpy import matrix, asscalar
from numpy.linalg import inv


alpha = 5 #y-intercept
beta = 10 #slope
error_std_dev = 3
n = 100
min = 0.01
max = 1

plot_ax = plt.axes([0.1, 0.2, 0.8, 0.65])
slider_ax = plt.axes([0.1, 0.05, 0.8, 0.05])


xvals = [min + x*(max-min)/n for x in range(n)]
X = matrix([[1,x] for x in xvals])


y_exact = [beta*x + alpha for x in xvals]
errors = [randn(0,error_std_dev) for x in range(n)]
y_measured = [y_exact[i] + errors[i] for i in range(n)]
y_measured_matrix = matrix([[y] for y in y_measured]) #turn list into nx1 matrix (vector)


OLS = inv(X.transpose() * X) * X.transpose() * y_measured_matrix #Estimating alpha and beta
alpha_hat = OLS[0][0].item()
beta_hat = OLS[1][0].item()
y_estimated = [alpha_hat + beta_hat * x for x in xvals]
print(f"true intercept = {alpha}, true slope = {beta}\n\nestimated intercept = {alpha_hat}, estimated slope = {beta_hat}")




# fig,ax = plt.subplots()

plt.axes(plot_ax)
line1 = plt.plot(xvals,y_measured,'b^')
line2 = plt.plot(xvals,y_estimated,'r--')
plt.ylabel('y values')
plt.xlabel('x values')
plt.title('OLS Regression')

beta_slider = Slider(slider_ax, 'slope', 0.1, 30.0, valinit=10, valstep=0.4)

def update(a):
	global line1,line2
	y_exact = [beta*x + alpha for x in xvals]
	errors = [randn(0,error_std_dev) for x in range(n)]
	y_measured = [y_exact[i] + errors[i] for i in range(n)]
	y_measured_matrix = matrix([[y] for y in y_measured]) #turn list into nx1 matrix (vector)
	OLS = inv(X.transpose() * X) * X.transpose() * y_measured_matrix #Estimating alpha and beta
	alpha_hat = OLS[0][0].item()
	beta_hat = OLS[1][0].item()
	y_estimated = [alpha_hat + beta_hat * x for x in xvals]
	line1.set_data(xvals,y_measured)
	line2.set_data(xvals,y_estimated)
	print(f"true intercept = {alpha}, true slope = {beta}\nestimated intercept = {alpha_hat}, estimated slope = {beta_hat}")
	line1 = plt.plot(xvals,y_measured,'b^')
	line2 = plt.plot(xvals,y_estimated,'r--')
# beta = Slider(axamp, 'Amp', 0.1, 10.0, valinit=a0)
# error_std_dev = Slider(axamp, 'Amp', 0.1, 10.0, valinit=a0)

beta_slider.on_changed(update)




plt.show()
