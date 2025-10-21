function u_p = evalUp(U,V,deltaT,R,R_ant)
    u_p(:,:,1) = U + deltaT*(3/2*R(:,:,1)-1/2*R_ant(:,:,1));
    u_p(:,:,2) = V + deltaT*(3/2*R(:,:,2)-1/2*R_ant(:,:,2));
end
