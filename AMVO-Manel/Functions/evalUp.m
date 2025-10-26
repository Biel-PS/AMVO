function u_p = evalUp(U,V,deltaT,R,R_ant)
% u_p = evalUp(U,V,deltaT,R,R_ant)
% Computes the predicted velocity using a second-order Adams-Bashforth scheme
% Author: Pau Andrés Pérez, 2025
%
% Input:
%    U, V     : 2D velocity fields 
%   deltaT   : time step
%   R        : current residuals of momentum equations (3D array)
%   R_ant    : previous residuals of momentum equations (3D array)
%
% Output:
% u_p : predicted velocity field (3D array)
%       u_p(:,:,1) corresponds to u-component
%       u_p(:,:,2) corresponds to v-component

    u_p(:,:,1) = U + deltaT * (3/2 * R(:,:,1) - 1/2 * R_ant(:,:,1));
    u_p(:,:,2) = V + deltaT * (3/2 * R(:,:,2) - 1/2 * R_ant(:,:,2));
end
