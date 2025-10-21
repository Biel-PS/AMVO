function DU = diffusive_u (U,L)

h = L/(size(U,1)-2);

DU = zeros(size(U,1),size(U,2));
    for i = 2:(size(U,1)-1)
        for j = 2:(size(U,2)-1)
        
            du_dxe = (U(i+1,j)-U(i,j))/(h);
            du_dxw = (U(i,j)-U(i-1,j))/(h);
             
            du_dxn = (U(i,j+1)-U(i,j))/(h);
            du_dxs = (U(i,j)-U(i,j-1))/(h);

            DU(i,j) = h*(du_dxe - du_dxw + du_dxn - du_dxs);

        end
    end
end