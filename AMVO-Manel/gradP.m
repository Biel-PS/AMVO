function [gx,gy] = gradP(p,h)
% [gx,gy] = gradP(p,h)
% Computes the discrete gradient of a 2D pressure field
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   p : 2D pressure field 
%   h : grid spacing
%
% Output:
%   gx : dp/dx at cell centers 
%   gy : dp/dy at cell centers 

    N = size(p,1) - 2;     
    gx = zeros(N+2, N+2);   
    gy = zeros(N+2, N+2);    

    for i = 2:N+1
        for j = 2:N+1
            gx(i,j) = (p(i+1,j) - p(i,j)) / h;
        end
    end

    for i = 2:N+1
        for j = 2:N+1
            gy(i,j) = (p(i,j+1) - p(i,j)) / h;
        end
    end
end

