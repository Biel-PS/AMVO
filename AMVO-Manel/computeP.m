function [u_new,divVelocityField,s] = computeP(h,N,u_p)

    U = u_p(:,:,1);
    V = u_p(:,:,2);
    
    d = diverg(U,V).*h;
    
    b = field2vector(d);
    
    A = laplacianMatrix(N);
    
    A(1,1) = -5;

    
    p = A\transpose(b);
    
    s = vector2field(p);
    
    s = halo_updateFuncion(s);
    
    [gx,gy] = gradP(s,h);
    
    
    gx = halo_updateFuncion(gx);
    gy = halo_updateFuncion(gy);
    
    ddd = diverg2(gx,gy,h);
    
    Unew = U - gx;
    Vnew = V - gy;
    
    Unew = halo_updateFuncion(Unew);
    Vnew = halo_updateFuncion(Vnew);

    u_new(:,:,1) = Unew;
    u_new(:,:,2) = Vnew;
    
    divVelocityField = diverg2(Unew,Vnew,h);

end