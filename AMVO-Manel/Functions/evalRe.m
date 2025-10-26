function tau = evalRe(U,V,L,Re)
% tau = evalRe(U,V,L,Re)
% Evaluates the characteristic time scale from velocity and Reynolds number
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   U, V : 2D velocity fields (including halo cells)
%   L    : characteristic length of the domain
%   Re   : Reynolds number
%
% Output:
%   tau : estimated characteristic time scale, tau = U_max * L / Re

    u = max(max(max(V)), max(max(U)));  % maximum velocity in the domain
    tau = u * L / Re;
end
