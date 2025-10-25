function [u_new, divVelocityField, s] = computeP(h, N, u_p)
% [u_new, divVelocityField, s] = computeP(h, N, u_p)
% Computes the pressure correction and updates the velocity field
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   h    : grid spacing
%   N    : number of internal cells per direction
%   u_p  : predicted velocity field (3D array)
%
% Output:
%   u_new            : corrected velocity field (3D array)
%   divVelocityField : divergence of corrected velocity field
%   s                : 2D pressure field 


    U = u_p(:,:,1);
    V = u_p(:,:,2);
    

    d = diverg(U,V) * h;
    
    % Convert divergence to vector and build Laplacian matrix
    b = field2vector(d);
    A = laplacianMatrix(N);    
    A(1,1) = -5;
    
    p = A \ transpose(b);
   
    % Convert solution vector to 2D pressure field
    s = vector2field(p);
    s = halo_updateFuncion(s);
    
    % Compute pressure gradients
    [gx, gy] = gradP(s, h);
    gx = halo_updateFuncion(gx);
    gy = halo_updateFuncion(gy);
        
    % Correct velocity field
    Unew = U - gx;
    Vnew = V - gy;
    Unew = halo_updateFuncion(Unew);
    Vnew = halo_updateFuncion(Vnew);

    u_new(:,:,1) = Unew;
    u_new(:,:,2) = Vnew;
    
    % Compute divergence of corrected velocity
    divVelocityField = diverg2(Unew, Vnew, h);
end
