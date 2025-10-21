function [u,v] = set_velocity_field ()
% [u,v] = set_velocity_field ()
% Defines a 2D symbolic velocity field (u,v)
% Author: Pau Andrés Pérez, 2025
% Input:
%   None (symbolic variables x and y are created internally)
% Output:
%   u : velocity component in x-direction, u = cos(2πx)*sin(2πy)
%   v : velocity component in y-direction, v = -sin(2πx)*cos(2πy)

    syms x y
    u = cos(2*pi*x)*sin(2*pi*y);
    v = -sin(2*pi*x)*cos(2*pi*y);
end
