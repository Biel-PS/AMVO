function print_field (u)
    N = size(u,1)-2;
    for j=N+2:-1:1
        fprintf('j=%2*d  ',j);
        for i=1:N+2
            fprintf (' %8.3e', u(i,j));
        end
        fprintf('\n');
    end
end 