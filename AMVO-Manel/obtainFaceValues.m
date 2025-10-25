function [ue, uw, un, us] = obtainFaceValues(U,i,j)
% [ue, uw, un, us] = obtainFaceValues(U,i,j)
% Computes interpolated velocity values at the four cell faces
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   U : 2D velocity field matrix
%   i, j : indices of the current cell
%
% Output:
%   ue : interpolated value at the east face
%   uw : interpolated value at the west face
%   un : interpolated value at the north face
%   us : interpolated value at the south face

    ue = avgField(U(i+1,j), U(i,j));
    uw = avgField(U(i-1,j), U(i,j));
    un = avgField(U(i,j+1), U(i,j));
    us = avgField(U(i,j-1), U(i,j));
end
