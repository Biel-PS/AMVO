function F = halo_updateFuncion (F)
    N = size(F,1)-2;
    F(1,:) = F(N+1,:);
    F(N+2,:) = F(2,:);

    F(:,1) = F(:,N+1);
    F(:,N+2) = F(:,2);
end