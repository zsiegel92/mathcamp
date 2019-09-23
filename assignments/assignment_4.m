aalpha = 1/3;
bbeta = 0.96;
A = 1;
ddelta = 0.08;
T = 100;
k1_guess =100;
tolerance = 1e-10;
k = zeros(T+1,1);
g = @(k0,k1,k2) (A*k1^aalpha + (1-ddelta)*k1-k2) ...
    - bbeta*(A*k0^aalpha + (1-ddelta)*k0 - k1)...
    *(aalpha*A*k1^(aalpha-1) + (1-ddelta));
gss = @(kss) g(kss,kss,kss);
kss = fzero(gss,100,optimset('Display','off'));

kss_guesses = zeros(1000);
number_kss_guesses = 0;
k0=0.1*kss;
k(1) = k1_guess;
while abs(k(T+1) - kss) > tolerance && number_kss_guesses<1000
    f2 = @(k2) g(k0,k(1),k2);
    k(2) = fzero(f2,k(1),optimset('Display','off'));
    for i = 1:T-1
        f = @(k2)g(k(i),k(i+1),k2);
        k(i+2) = fzero(f,k(i+1),optimset('Display','off'));
    end
    if abs(k(T+1) - kss) > tolerance
        k(1) = k(1) -  0.5*(k(T+1) - kss); %UPDATE k1 GUESS
    end
    kss_guesses(number_kss_guesses+1) = k(T+1);
    number_kss_guesses = number_kss_guesses + 1;
    if rem(number_kss_guesses,10)==0
       disp(num2str(number_kss_guesses) + " simulations performed!");
    end
end
disp("Number of kss guesses is " + num2str(number_kss_guesses));
f = figure('visible','off');
plot(1:number_kss_guesses,kss_guesses(1:number_kss_guesses),'b',1:number_kss_guesses,kss*ones(number_kss_guesses,1),'r--');%,1:number_kss_guesses,repmat(kss,1),'r--'
xlabel("Simulation Number");
ylabel("Value of K_{T+1}");
title("Value of K_{T+1} During Iterations of Algorithm")
saveas(f,'shared/convergence_over_iterations','png');


plot(1:T+1,k,'b',1:number_kss_guesses,kss*ones(number_kss_guesses,1),'r--')
xlabel("Time Step");
ylabel("Value of k");
title("Values of K During Final Simulation")
saveas(f,'shared/time_series','png');
