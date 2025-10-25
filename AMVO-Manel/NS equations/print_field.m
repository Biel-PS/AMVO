function print_field(u)
% print_field(u)
% Prints the 2D field values to the console
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   u : 2D matrix (including halo cells)
%
% Output:
%   None (prints field values to the command window)


    N = size(u,1) - 2;
    for j = N+2:-1:1
        fprintf('j=%2d  ', j);
        for i = 1:N+2
            fprintf(' %8.3e', u(i,j));
        end
        fprintf('\n');
    end
end
