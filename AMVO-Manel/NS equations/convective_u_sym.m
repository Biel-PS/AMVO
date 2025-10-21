function cu = convective_u_sym (u,v,x,y)
% cu = convective_u_sym(u,v,x,y)
% Computes the symbolic convective term of the velocity component u
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   u : symbolic expression of velocity component u(x,y)
%   v : symbolic expression of velocity component v(x,y)
%   x, y : symbolic spatial variables
%
% Output:
%   cu : symbolic convective term, cu = u*(du/dx) + v*(du/dy)
%
% Disclaimer:
%   u,v,x,y are relative to this function, so the notation of
%   the velocity field from the main code doesn't have to mach
%   that of this function.
    cu = u*diff(u,x) + v*diff(u,y);
end