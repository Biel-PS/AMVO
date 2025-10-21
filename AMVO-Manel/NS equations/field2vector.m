function b = field2vector(p)
    N = size(p,1) - 2;
    b = zeros(1,N*N);
    counter = 1;
    for j = 2:(N+1)
        for i = 2:(N+1)
            b(counter) = p(i,j);
            counter = counter +1;
         end
        
    end

end
