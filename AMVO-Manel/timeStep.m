function deltaT = timeStep(U,V,h,tau)
    deltaTcu = min(min(h./abs(U)));
    deltaTcv = min(min(h./abs(V)));
    deltaTc = min(deltaTcu,deltaTcv);
    deltaTd = 1/2*min(h^2/tau);
    deltaT = 0.25*min(deltaTc,deltaTd);
end