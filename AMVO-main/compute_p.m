function P = compute_p(p_num,N,h)

    P = zeros (N+2,N+2);
    
    for i = 2:(N+1)
        for j = 2:(N+1)
            pointP = [(i-2)*h + h/2  ,  (j-2)*h + h/2];
            P(i,j) = p_num(pointP(1),pointP(2));
        end
    end
end