function du = diffusive_u (U,h)
    
du = zeros(size(U,1),size(U,2));
    for i = 2:(size(U,1)-1)
        for j = 1:(size(U,2)-1)
        
            du_dxe = (U(i+1,j)-U(i,j))/(h);
            du_dxw = (U(i,j)-U(i-1,j))/(h);
            du(i,j) = h*(du_dxe - du_dxw);

        end
    end
end