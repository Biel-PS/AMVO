function [gx,gy] = gradP (p,h)
    
    N = size(p,1)-2;        % número de volúmenes de control
    gx = zeros(N+2,N+2);    % gradiente en x (staggered en x)
    gy = zeros(N+2,N+2);    % gradiente en y (staggered en y)

    % gradiente en x
    for i = 2:N+1
        for j = 2:N+1
            gx(i,j) = (p(i+1,j) - p(i,j)) / h;
        end
    end

    % gradiente en y
    for i = 2:N+1
        for j = 2:N+1
            gy(i,j) = (p(i,j+1) - p(i,j)) / h;
        end
    end

end