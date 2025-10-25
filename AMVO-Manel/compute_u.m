function [U,V] = compute_u(u_num,v_num,N,h)
% [U,V] = compute_u(u_num,v_num,N,h)
% Computes staggered 2D velocity fields from analytical functions
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   u_num, v_num : function handles for the analytical u and v velocities
%   N            : number of internal cells per direction
%   h            : grid spacing
%
% Output:
%   U, V : 2D velocity fields with halo cells, staggered on the grid

    U = zeros(N+2, N+2);
    V = zeros(N+2, N+2);
    
    for i = 2:(N+1)
        for j = 2:(N+1)

            pointU = [(i-2)*h + h,   (j-2)*h + h/2];
            pointV = [(i-2)*h + h/2, (j-2)*h + h];
            
            U(i,j) = u_num(pointU(1), pointU(2));
            V(i,j) = v_num(pointV(1), pointV(2));
        end
    end
end