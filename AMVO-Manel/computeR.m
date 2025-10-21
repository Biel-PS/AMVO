function R = computeR(U,V,L,h,tau)
    
    CU = 1/(h^2) .* convective_u (U,V,L,'u');
    DU = 1/(h^2) .* diffusive_u (U,L) .* tau;

    CV = 1/(h^2) .* convective_u (V,U,L,'v');
    DV = 1/(h^2) .* diffusive_u (V,L) .* tau;

    R(:,:,1) = -CU + DU;
    R(:,:,2) = -CV + DV;

end