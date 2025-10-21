function [u,v] = set_velocity_field ()
    syms x y
    u = cos(2*pi*x)*sin(2*pi*y);
    v = -sin(2*pi*x)*cos(2*pi*y);
end
