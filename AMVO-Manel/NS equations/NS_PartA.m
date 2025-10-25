%% NS_PartA.m

% Performs a convergence study for convective and diffusive terms
% Author: Biel Pujadas Suriol & Pau Andrés Pérez, 2025


clear; clc; close all;

L = 1;
tau = 1;
syms x y

elementNumberVector = 10:10:100;
elementSizeVector = L ./ elementNumberVector;

error_convective  = zeros(size(elementNumberVector));
error_diffusive   = zeros(size(elementNumberVector));
error_convectiveV = zeros(size(elementNumberVector));
error_diffusiveV  = zeros(size(elementNumberVector));

counter = 1;

[u,v] = set_velocity_field();

du_analytic = matlabFunction(diffusive_u_sym(u), 'Vars',[x y]);
cu_analytic = matlabFunction(convective_u_sym(u,v,x,y), 'Vars',[x y]);

dv_analytic = matlabFunction(diffusive_u_sym(v), 'Vars',[x y]);
cv_analytic = matlabFunction(convective_u_sym(v,u,y,x), 'Vars',[x y]);

u_num = matlabFunction(u, 'Vars',[x y]);
v_num = matlabFunction(v, 'Vars',[x y]);
    
for N = elementNumberVector
    h = L / N;
    
    U = zeros(N+2, N+2);
    V = zeros(N+2, N+2);

    DU_analytic = zeros(N+2, N+2);
    CU_analytic = zeros(N+2, N+2);
    DV_analytic = zeros(N+2, N+2);
    CV_analytic = zeros(N+2, N+2);
    
    for i = 2:(N+1)
        for j = 2:(N+1)
            pointU = [(i-2)*h + h,    (j-2)*h + h/2];
            pointV = [(i-2)*h + h/2,  (j-2)*h + h];
           
            U(i,j) = u_num(pointU(1), pointU(2));
            V(i,j) = v_num(pointV(1), pointV(2));

            DU_analytic(i,j) = tau * du_analytic(pointU(1), pointU(2));
            CU_analytic(i,j) = cu_analytic(pointU(1), pointU(2));
            DV_analytic(i,j) = tau * dv_analytic(pointV(1), pointV(2));
            CV_analytic(i,j) = cv_analytic(pointV(1), pointV(2));
        end
    end

    U = halo_updateFuncion(U);
    V = halo_updateFuncion(V);

    CU = (1/h^2) * convective_u(U, V, L, 'u');
    DU = (1/h^2) * diffusive_u(U, L) * tau;

    CV = (1/h^2) * convective_u(V, U, L, 'v');
    DV = (1/h^2) * diffusive_u(V, L) * tau;
    
    error_convective(counter)  = max(max(abs(CU - CU_analytic)));
    error_diffusive(counter)   = max(max(abs(DU - DU_analytic)));
    error_convectiveV(counter) = max(max(abs(CV - CV_analytic)));
    error_diffusiveV(counter)  = max(max(abs(DV - DV_analytic)));

    counter = counter + 1;
end

%% Plot results
figure;
loglog(elementSizeVector, error_diffusive, 'r', 'DisplayName', 'Error diffusive u'); 
hold on;
loglog(elementSizeVector, error_convective, 'b', 'DisplayName', 'Error convective u');
loglog(elementSizeVector, elementSizeVector.^2, 'k--', 'DisplayName', 'h^2'); 
loglog(elementSizeVector, error_diffusiveV, '--g', 'DisplayName', 'Error diffusive v'); 
loglog(elementSizeVector, error_convectiveV, '--y', 'DisplayName', 'Error convective v');
legend show
xlabel('Grid size (h)')
ylabel('Error')
title('Convergence of convective and diffusive terms')
grid on;
hold off


% 
% print_field(U);
% fprintf("v \n");
% print_field(V);
% 



