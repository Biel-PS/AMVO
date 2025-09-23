function cu = convective_u (u,v,point)
syms x y
field = u*diff(u,x) + v*diff(u,y);
cu = fsolve(field,point);
end