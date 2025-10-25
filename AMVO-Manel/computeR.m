function R = computeR(U,V,L,h,tau)
% R = computeR(U,V,L,h,tau)
% Computes the residual of the momentum equations for 2D flow
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   U, V : 2D velocity fields
%   L    : domain length
%   h    : grid spacing
%   tau  : time step or scaling factor
%
% Output:
%   R(:,:,1) corresponds to u-momentum residual
%   R(:,:,2) corresponds to v-momentum residual

    CU = 1/(h^2) .* convective_u(U,V,L,'u');
    DU = 1/(h^2) .* diffusive_u(U,L) .* tau;

    CV = 1/(h^2) .* convective_u(V,U,L,'v');
    DV = 1/(h^2) .* diffusive_u(V,L) .* tau;

    R(:,:,1) = -CU + DU;
    R(:,:,2) = -CV + DV;
end