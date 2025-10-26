function d = vector2field(b)
% d = vector2field(b)
% Converts a 1D vector into a 2D field
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   b : 1D vector containing internal field values
%
% Output:
%   d : 2D matrix reconstructed from vector

    N = sqrt(length(b));
    d = zeros(N+2, N+2);
    counter = 1;

    for j = 2:(N+1)
        for i = 2:(N+1)
            d(i,j) = b(counter);
            counter = counter + 1;
        end
    end
end
