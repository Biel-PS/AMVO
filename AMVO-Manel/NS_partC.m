%% NS_PartC.m

% Time implementation of Part B. 
% Author: Biel Pujadas Suriol & Pau Andrés Pérez, 2025

clear;close all;clc
rho = 1.225;
L = 1;
Re = 100;
syms x y t
tEnd = 2;
tStep = 0.006;
T = 0:tStep:tEnd;

Ypoint = 5;
Xpoint = 3;
Xpoint_0 = 2;
Ypoint_0 = 3;

[u,v] = set_velocity_field();
u_num = matlabFunction(u, 'Vars',[x y]);
v_num = matlabFunction(v, 'Vars',[x y]);

counterMesh = 1;

for N = 10:5:30

    h = L/N;


    [U,V] = compute_u(u_num,v_num,N,h);
    U = halo_updateFuncion(U);
    V = halo_updateFuncion(V);


    if counterMesh == 1
        tau = evalRe(U,V,L,Re);
    end


    F = exp(-8*pi^2*tau*t);
    F_fun = matlabFunction(F);
    p_sym = (cos(2*pi*x))^2/2 + (cos(2*pi*y))^2/2;
    p_num = matlabFunction(p_sym, 'Vars', [x, y]);


    F_testing = arrayfun(F_fun, T);

    U_ana = U(Ypoint,Xpoint) .* F_testing;
    V_ana = V(Ypoint,Xpoint) .* F_testing;
    dp_ana = -rho * F_testing.^2 .* ...
        (p_num((Ypoint*h - h/2),(Xpoint*h - h/2)) - ...
         p_num((Xpoint_0*h - h/2),(Ypoint_0*h - h/2)));


    results = zeros(length(T), 3);
    results(1,1) = U_ana(1) ; 
    results(1,2) = V_ana(1) ;   

    U = U .* F_testing(1);
    V = V .* F_testing(1);

    R = computeR(U,V,L,h,tau);
    R(:,:,1) = halo_updateFuncion(R(:,:,1));
    R(:,:,2) = halo_updateFuncion(R(:,:,2));


    for i = 2:length(T)
        R_ant = R;
        R = computeR(U,V,L,h,tau);
        R(:,:,1) = halo_updateFuncion(R(:,:,1));
        R(:,:,2) = halo_updateFuncion(R(:,:,2));


        u_p = evalUp(U,V,tStep,R,R_ant);
        u_p(:,:,1) = halo_updateFuncion(u_p(:,:,1));
        u_p(:,:,2) = halo_updateFuncion(u_p(:,:,2));


        [u_new,divVelocityField,s] = computeP(h,N,u_p);


        results(i,3) = s(Ypoint+1,Xpoint+1) - s(Ypoint_0+1,Xpoint_0+1);
        results(i,1) = u_new(Ypoint,Xpoint,1);
        results(i,2) = u_new(Ypoint,Xpoint,2);

        U = halo_updateFuncion(u_new(:,:,1));
        V = halo_updateFuncion(u_new(:,:,2));
    end


    results(:,3) = results(:,3) .* rho / tStep;


    errorU(counterMesh) = max(max(abs(results(:,2) - V_ana(:))),max(abs(results(:,1) - U_ana(:))));

    hVector(counterMesh) = h;

    counterMesh = counterMesh + 1;
end


figure;
loglog(hVector, hVector.^2, '--', 'DisplayName', 'h^2');
hold on;
loglog(hVector, errorU, 'o-', 'DisplayName', 'Error velocity');

hold off;
xlabel('h');
ylabel('Error velocity');
legend('show', 'Location', 'best');
title('Convergencia espacial (esperado O(h^2))');
grid on;
set(gca,'LooseInset',get(gca,'TightInset'));
print(gcf,'-dsvg','convergence_velocity.svg');

figure;
plot(T, results(:,1), T, results(:,2), 'LineWidth',1.1);
hold on;
plot(T, U_ana, '--', T, V_ana, '--', 'LineWidth',1.1);
legend('U_n','V_n','U_a','V_a','Location','best');
xlabel('Time (s)');
ylabel('Velocity at (3,3)');
title('Analytic vs Numeric Velocity Evolution');
grid on;
hold off;
print(gcf,'-dsvg','velocity_time.svg');

figure;
plot(T(2:end), results(2:end,3), T(2:end), dp_ana(2:end), '--', 'LineWidth',1.1);
legend('P_n','P_a','Location','best');
xlabel('Time (s)');
ylabel('Pressure difference (3,3)-(3,4)');
title('Analytic vs Numeric Pressure Difference');
grid on;
set(gca,'LooseInset',get(gca,'TightInset'));
print(gcf,'-dsvg','pressure_comparison.svg');