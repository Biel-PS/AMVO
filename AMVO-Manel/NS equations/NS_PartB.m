%% NS_PartB.m

% Implementation of preassure-velocity coupling
% Author: Biel Pujadas Suriol & Pau Andrés Pérez, 2025
clear; clc; close all;

L = 1;
tau = 1;
syms x y

N = 4;

[u,v] = set_velocity_field();

u_num = matlabFunction(u, 'Vars',[x y]);
v_num = matlabFunction(v, 'Vars', [x y]);

h = L/N;

U = zeros (N+2,N+2);
V = zeros (N+2,N+2);

for i = 2:(N+1)
    for j = 2:(N+1)
        pointU = [(i-2)*h + h  ,  (j-2)*h + h/2];
        pointV = [(i-2)*h + h/2  , (j-2)*h + h];

        U(i,j) = u_num(pointU(1),pointU(2));
        V(i,j) = v_num(pointV(1),pointV(2));

    end
end

% U = [0 0 0 0 0; 0 0 0 0 0; 0 0 1 0 0; 0 0 0 0 0; 0 0 0 0 0];
% V = [0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0];

U = halo_updateFuncion(U);
V = halo_updateFuncion(V);

u_p(:,:,1) = U;
u_p(:,:,2) = V;

N = size(U,1)-2;
h = L/N;

[u_new, divVelocityField, s] = computeP(h, N, u_p);


