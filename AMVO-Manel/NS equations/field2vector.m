function b = field2vector(p)
% b = field2vector(p)
% Converts a 2D field (with halo cells) into a 1D vector
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   p : 2D matrix 
%
% Output:
%   b : 1D vector containing the internal field values (row-wise order)

    N = size(p,1) - 2;
    b = zeros(1, N * N);
    counter = 1;

    for j = 2:(N+1)
        for i = 2:(N+1)
            b(counter) = p(i,j);
            counter = counter + 1;
        end
    end
end
