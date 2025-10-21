function CV = convective_v (U,V,L)
   
    n = size(U,1)-2;
    m = size(U,2)-2;
    h = L/n;
    CV = zeros(n+2,m+2);
    
    for i = 2:(n+1)
        for j = 2:(m+1)

            [ve, vw, vn, vs] = obtainFaceValues (V,i,j);
            [Fe, Fw, Fn, Fs] = obtainFlowTerms (U,V,h,i,j);
            
            CV(i,j) = (ve*Fe - vw*Fw + vn*Fn - vs*Fs);
        end
    end

end