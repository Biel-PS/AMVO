function cu = convective_u_sym (u,v,x,y,type)
% cu = convective_u_sym(u,v,x,y)
% Computes the symbolic convective term of the velocity component u
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   u : symbolic expression of velocity component u(x,y)
%   v : symbolic expression of velocity component v(x,y)
%   x, y : symbolic spatial variables
%   type : deffines the type of convective evaluation done.
%
% Output:
%   cu : symbolic convective term, in defalut :cu = u*(du/dx) + v*(du/dy)
%        when deffined by the user: (d(u*u)/dx) + (d(v*u)/dy)
% Disclaimer:
%   u,v,x,y are relative to this function, so the notation of
%   the velocity field from the main code doesn't have to mach
%   that of this function.

if nargin < 5
    type = "null";
end

switch type
    case 'div'
        cu = diff(u*u,x) + diff(v*u,y);
    otherwise
        cu = u*diff(u,x) + v*diff(u,y);
end