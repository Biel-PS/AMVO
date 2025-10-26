function D = diverg(U,V)
% D = diverg(U,V)
% Computes the discrete divergence of a 2D velocity field
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   U, V : 2D velocity component matrices
%
% Output:
%   D : divergence field, D = dU/dx + dV/dy (discrete approximation)

    n = size(U,1) - 2;
    m = size(U,2) - 2;
    D = zeros(n+2, m+2);
    
    for i = 2:(n+1)
        for j = 2:(m+1)
            D(i,j) = (V(i,j) - V(i,j-1)) + (U(i,j) - U(i-1,j));
        end
    end
end
