function F = halo_updateFuncion(F)
% F = halo_updateFuncion(F)
% Updates halo cells in a 2D periodic field
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   F : 2D array with halo cells at the borders
%
% Output:
%   F : updated field with periodic boundary conditions

    N = size(F,1) - 2;
    F(1,:) = F(N+1,:);
    F(N+2,:) = F(2,:);
    F(:,1) = F(:,N+1);
    F(:,N+2) = F(:,2);
end