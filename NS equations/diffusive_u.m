function du = diffusive_u(u,point)
    syms x y 
    field = diff(u,x,x) + diff(u,y,y);
    fsolve(field,point);
end