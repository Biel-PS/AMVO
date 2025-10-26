%% NS_PartC.m

% Time implementation of Part B. 
% Author: Biel Pujadas Suriol & Pau Andrés Pérez, 2025
clear; clc; close all;

rho = 1.225;
L = 1;
Re = 100;
syms x y t
N = 10;
h = L/N;
tStep = 0.001;
T = 0:tStep:2;
results = zeros(size(t,1),2);
counter = 1;

[u,v] = set_velocity_field();
u_num = matlabFunction(u, 'Vars',[x y]);
v_num = matlabFunction(v, 'Vars', [x y]);
error =0;
counterMesh = 1;

for N = 10
    h = L/N;
    [U,V] = compute_u(u_num,v_num,N,h);
    U = halo_updateFuncion(U);
    V = halo_updateFuncion(V);
    tau = evalRe(U,V,L,Re);
    R = computeR(U,V,L,h,tau);
    R(:,:,1) = halo_updateFuncion(R(:,:,1));
    R(:,:,2) = halo_updateFuncion(R(:,:,2));
    
    
    F = exp(-8*pi^2*tau*t);
    F_test = matlabFunction(F);
    p_sym = (cos(2*pi*x))^2/2 + (cos(2*pi*y))^2/2;
    
    
    p_num  = matlabFunction(p_sym,  'Vars', [x, y]);
    
    F_testing = zeros(length(T),1);
    deltaT = zeros(length(T),1);
    
    for i = 1:1:length(T)
        F_testing(i) = F_test(T(i));
    end
    U_ana = U(3,3)*F_testing;
    V_ana = V(3,3)*F_testing;
    
    dp_ana = -rho*F_testing.^2*(p_num((3*h-h/2),(3*h-h/2)) -  p_num((4*h-h/2),(3*h-h/2)));
    
    for time = T
    
        R_ant = R;
        R = computeR(U,V,L,h,tau);
        R(:,:,1) = halo_updateFuncion(R(:,:,1));
        R(:,:,2) = halo_updateFuncion(R(:,:,2));
        deltaT(counter) = timeStep(U,V,h,tau);
        u_p = evalUp(U,V,tStep,R,R_ant);
        [u_new,divVelocityField,s] = computeP(h,N,u_p);
    
        results(counter,1)=u_new(3,3,1);
        results(counter,2)=u_new(3,3,2);
        results(counter,3)=s(3,3) - s(3,4);
    
        counter = counter+1;
        U = u_new(:,:,1);
        V = u_new(:,:,2);

    end
    min(deltaT)
    error(counterMesh) = max(max(abs(results(:,1)-U_ana)),max(abs(results(:,2)-V_ana)));
    hVector(counterMesh) = h;
    counterMesh = counterMesh + 1
    counter = 1;
end
% Testing of the code

figure();


% Dibuja los puntos en escala log-log
loglog(hVector, hVector.^2, '--', 'DisplayName', 'h^2');
hold on;
loglog(hVector, error, 'o', 'DisplayName', 'Error');
hold off;

% Etiquetas y leyenda
xlabel('h');
ylabel('Error velocity');
legend('show');
set(gca,'LooseInset',get(gca,'TightInset'));
print(gcf,'-dsvg','convergence.svg');



results(:,3) = results(:,3)*-rho/tStep;
figure
hold on
plot(T, results(:,1), T, results(:,2))
plot(T, U_ana, '--', T, V_ana, '--')

legend('U_n','V_n', ...
       'U_a','V_a', ...
       'Location','best')


legend show
xlabel('Time (s)')
ylabel('Velocity at position (3,3)')
title('Comparison of analytic and numeric velocities as a function of time')
grid on;
hold off
set(gca,'LooseInset',get(gca,'TightInset'));
print(gcf,'-dsvg','convergence.svg');



figure();

plot(T, results(:,3),T,dp_ana);

legend('P_n','P_a', ...
       'Location','best')
legend show
xlabel('Time (s)')
ylabel('Difference of preassure (3,3)-(3,4)')
title('Comparison of the analytic and nunmerical difference of preassure at a node as a function of time')
grid on;
set(gca,'LooseInset',get(gca,'TightInset'));
print(gcf,'-dsvg','convergence.svg');