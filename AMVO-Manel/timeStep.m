function deltaT = timeStep(U,V,h,tau)
% deltaT = timeStep(U,V,h,tau)
% Computes a stable time step
% Author: Pau Andrés Pérez, 2025
%
% Input:
%   U, V : 2D velocity fields 
%   h    : grid spacing
%   tau  : characteristic diffusion time 
%
% Output:
%   deltaT : suggested time step based on CFL and diffusive constraints


    deltaTcu = min(min(h ./ abs(U)));  % CFL from u
    deltaTcv = min(min(h ./ abs(V)));  % CFL from v
    deltaTc = min(deltaTcu, deltaTcv); % overall convective limit

    deltaTd = 0.5 * min(h^2 / tau);    % diffusive limit
    deltaT = 0.25 * min(deltaTc, deltaTd); % safety factor
end
