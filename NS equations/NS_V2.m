clear; clc; close all
L = 1;
N = 3;
h = L/N;
% 
% [u,v] = set_velocity_field();


U = zeros (N+2,N+2);
V = zeros (N+2,N+2);



for i = 2:(N+1)
    for j = 2:(N+1)

        pointU = [(i-2)*h  ,  (j-2)*h + h/2];
        pointV = [(i-2)*h + h/2  , (j-2)*h];

        U(i,j) = pointU(1);
        V(i,j) = pointU(2);

        % cu = convective_u(u,v,h);
        % du = diffusive_u(u,h);
    end
end

print_field(U);
fprintf("v \n");
print_field(V);




