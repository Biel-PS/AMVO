function D = diverg2(U,V,h)
% D = diverg2(U,V,h)
% Computes the discrete divergence of a 2D velocity field with spacing h
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   U, V : 2D velocity component matrices
%   h    : grid spacing
%
% Output:
%   D : divergence field, D = dU/dx + dV/dy

    n = size(U,1) - 2;
    m = size(U,2) - 2;
    D = zeros(n+2, m+2);
    
    for i = 2:(n+1)
        for j = 2:(m+1)
            D(i,j) = (U(i,j) - U(i-1,j))/h + (V(i,j) - V(i,j-1))/h;
        end
    end
end