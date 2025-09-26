function cu = convective_u_sym (u,v)
    syms x y 
    cu = u*diff(u,x) + v*diff(u,y);
end