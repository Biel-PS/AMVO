function CU = convective_u(U,V,L,type)
% CU = convective_u(U,V,L,type)
% Computes the discrete convective term of the velocity component U
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   U, V : 2D matrices of velocity components
%   L    : domain length
%   type : scheme type
%
% Output:
%   CU : convective term of U computed at cell centers

    n = size(U,1) - 2;
    m = size(U,2) - 2;
    h = L / n;
    CU = zeros(n+2, m+2);
    
    for i = 2:(n+1)
        for j = 2:(m+1)
            [ue, uw, un, us] = obtainFaceValues(U, i, j);
            [Fe, Fw, Fn, Fs] = obtainFlowTerms(U, V, h, i, j, type);
            CU(i,j) = (ue*Fe - uw*Fw + un*Fn - us*Fs);
        end
    end
end