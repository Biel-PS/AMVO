clear; clc; close all;


L = 1;
tau = 0.1;
syms x y

elementNumberVector = 20:20:200;
elementSizeVector = L./elementNumberVector;

error_convective = zeros(size(elementNumberVector,2),1);
error_diffusive = zeros(size(elementNumberVector,2),1);
counter = 1;

[u,v] = set_velocity_field();

for N = elementNumberVector


    h = L/N;
    
    U = zeros (N+2,N+2);
    V = zeros (N+2,N+2);

    DU_analytic = zeros (N+2,N+2);
    CU_analytic = zeros (N+2,N+2);
    
    du_analytic = matlabFunction(diffusive_u_sym(u), 'Vars',[x y]);
    cu_analytic = matlabFunction(convective_u_sym(u,v), 'Vars',[x y]);
        
    u_num = matlabFunction(u, 'Vars',[x y]);
    v_num = matlabFunction(v, 'Vars', [x y]);
    
    
    for i = 2:(N+1)
        for j = 2:(N+1)
    
            pointU = [(i-2)*h  ,  (j-2)*h + h/2];
            pointV = [(i-2)*h + h/2  , (j-2)*h];
           
            U(i,j) = u_num(pointU(1),pointU(2));
            V(i,j) = v_num(pointV(1),pointV(2));

            U = halo_updateFuncion(U);
            V = halo_updateFuncion(V);

            DU_analytic(i,j) = tau .* du_analytic(pointU(1),pointU(2));
            CU_analytic(i,j) = cu_analytic(pointU(1),pointU(2));
        end
    end
    

    CU = 1/h^2 * convective_u (U,V,L);
    DU = 1/h^2 * diffusive_u (U,L) .* tau;
    
    max(max(abs(CU_analytic)))
    error_convective(counter) = max(max(abs(CU-CU_analytic)));
    error_diffusive(counter) = max(max(abs(DU-DU_analytic)));
    counter = counter+1;
end


figure();

loglog(elementSizeVector, error_diffusive, 'r', 'DisplayName', 'Error diffusive u'); 
hold on;

loglog(elementSizeVector, error_convective, 'b', 'DisplayName', 'Error convective u');
loglog(elementSizeVector, elementSizeVector.^2, 'k--', 'DisplayName', 'h^2'); 

legend show

hold off;


% 
% print_field(U);
% fprintf("v \n");
% print_field(V);
% 



