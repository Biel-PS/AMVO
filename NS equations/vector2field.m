function d = vector2field(b)
    N = sqrt(length(b));
    d = zeros(N+2,N+2);
    counter = 1;
    for i = (N+1):-1:2
        for j = 2:(N+1)
            d(i,j) = b(counter);
            counter = counter +1;
         end
        
    end

end
