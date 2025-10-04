function [gx,gy] = grad (p,h)
    
    N = size(p,1)-2;

    gx = zeros(N+2,N+2);
    gy = zeros(N+2,N+2);

    for j = 2:(N+1)
        for i = 2:(N+1)
            % gx(i,j) = ((p(i,j) - p(i-1,j))/h + gx(i-1,j))/2;
            % gy(i,j) = ((p(i,j) - p(i,j-1))/h + gy(i,j-1))/2;

            gx(i,j) = (p(i,j) - p(i-1,j))/h ;
            gy(i,j) = (p(i,j) - p(i,j-1))/h ;
        end 
    end
end