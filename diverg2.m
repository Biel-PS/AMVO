function D = diverg2(U,V,h)
   
    n = size(U,1)-2;
    m = size(U,2)-2;
    D = zeros(n+2,m+2);
    
    for i = 2:(n+1)
        for j = 2:(m+1)
            D(i,j) = (V(i,j) - V(i,j-1) + U(i,j) - U(i-1,j));
            % D(i,j) = (U(i,j) - U(i-1,j))/h + (V(i,j) - V(i,j-1))/h;
        end
    end

end