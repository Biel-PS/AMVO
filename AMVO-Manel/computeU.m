function [U,V] = computeU(u_num,v_num,F_num,N,h,t)

    U = zeros (N+2,N+2);
    V = zeros (N+2,N+2);
    
    for i = 2:(N+1)
        for j = 2:(N+1)
            pointU = [(i-2)*h + h  ,  (j-2)*h + h/2];
            pointV = [(i-2)*h + h/2  , (j-2)*h + h];
           
            U(i,j) = u_num(pointU(1),pointU(2))*F_num(t);
            V(i,j) = v_num(pointV(1),pointV(2))*F_num(t);
    
         end
        
    end
    
    U = halo_updateFuncion(U);
    V = halo_updateFuncion(V);
    
    % U = [0 0 0 0 0; 0 0 0 0 0; 0 0 1 0 0; 0 0 0 0 0; 0 0 0 0 0];
    % V = [0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0];

end