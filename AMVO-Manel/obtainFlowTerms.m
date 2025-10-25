function [Fe, Fw, Fn, Fs] = obtainFlowTerms(U,V,h,i,j,type)
% [Fe, Fw, Fn, Fs] = obtainFlowTerms(U,V,h,i,j,type)
% Computes mass flow terms at cell faces for the convective term
% Author: Biel Pujadas Suriol, 2025
%
% Input:
%   U, V : 2D velocity component matrices 
%   h    : cell size (spatial step)
%   i, j : indices of the current cell
%   type : specifies which velocity component is being treated ('u' or 'v')
%
% Output:
%   Fe : flow through the east face
%   Fw : flow through the west face
%   Fn : flow through the north face
%   Fs : flow through the south face

    switch type
        case 'u'
            Fs = h * avgField(V(i, j-1), V(i+1, j-1));
            Fn = h * avgField(V(i, j),   V(i+1, j));
            Fe = h * avgField(U(i+1, j), U(i, j));
            Fw = h * avgField(U(i-1, j), U(i, j));

        case 'v'
            Fs = h * avgField(U(i, j-1), U(i, j));
            Fn = h * avgField(U(i, j),   U(i, j+1));
            Fe = h * avgField(V(i, j),   V(i, j+1));
            Fw = h * avgField(V(i-1, j+1), V(i-1, j));
    end
end