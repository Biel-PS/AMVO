function A = laplacianMatrix(N)
    A = zeros(N^2,N^2);
    for j = 1:N
        for i = 1:N
            p = i+(j-1)*N;

            e = mod(i,   N) + 1 
            w = mod(i-2, N) + 1 
            n = mod(j,   N) + 1 
            s = mod(j-2, N) + 1 

            pe = (j-1)*N + e   
            pw = (j-1)*N + w   
            pn = (n-1)*N + i   
            ps = (s-1)*N + i   

            A(p,p)  = A(p,p) - 4;
            A(p,pe) = A(p,pe) + 1;
            A(p,pw) = A(p,pw) + 1;
            A(p,pn) = A(p,pn) + 1;
            A(p,ps) = A(p,ps) + 1;

        end
    end
end