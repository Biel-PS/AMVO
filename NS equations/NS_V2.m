clear; clc; close all;

L = 3;
N = 3;
h = L/N;
syms x y

[u,v] = set_velocity_field();

U_num = zeros (N+2,N+2);
V_num = zeros (N+2,N+2);

U = zeros (N+2,N+2);
V = zeros (N+2,N+2);

diffusive_analytic = diffusive_u_sym(u);
convective_analytic = convective_u_sym(u,v);

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
        
        

        error = abs()

        % cu = convective_u(u,v,h);
        % du = diffusive_u(u,h);
    end
end

print_field(U);
fprintf("v \n");
print_field(V);




