function du = diffusive_u_sym(u)
% du = diffusive_u_sym(u)
% Computes the diffusion term of a generic0 velocity field u
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   u : symbolic expression of the velocity field u(x,y)
% Output:
%   du : symbolic Laplacian of u, du = d2u/dx2 + d2u/dy2

    syms x y 
    du = diff(u,x,x) + diff(u,y,y);
end