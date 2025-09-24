function du = diffusive_u_sym(u)
    syms x y 
    du = diff(u,x,x) + diff(u,y,y);
end