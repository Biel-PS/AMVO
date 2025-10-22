clear;clc;close all;

nElem = 100;
radi  = 1;
Qinf  = [1,0];
elementBoundary = round(nElem*0.25);

mesh = getCircularMesh(radi,nElem);
plotMesh(mesh);

vector = getNormalVector (mesh);
vector = getTangentlVector (mesh,vector);

data.inducedVelocity.u    = zeros(mesh.nElem,mesh.nElem);
data.inducedVelocity.w    = zeros(mesh.nElem,mesh.nElem);
data.influenceCoefficient = zeros(mesh.nElem,mesh.nElem);
data.b                    = zeros(mesh.nElem,1);

for i = 1:1:mesh.nElem
    for j = 1:1:mesh.nElem
        
        x_GCP_i = mesh.controlCoord.cart(i,1); %x_GlobalControlPoint_i = x_GCP_i
        z_GCP_i = mesh.controlCoord.cart(i,2); %z_GlobalControlPoint_i = z_GCP_i


        [x_LCP_ij,z_LCP_ij,alpha_j] = global2Local(x_GCP_i,z_GCP_i,j,mesh); %Local control point i in j axes
        
        localNodej  = [0,0];
        localNodej1 = [mesh.ElemLength,0];

        theta_1 = getRelativeAngleFromPoint(localNodej,[x_LCP_ij,z_LCP_ij]);
        theta_2 = getRelativeAngleFromPoint(localNodej1,[x_LCP_ij,z_LCP_ij]);
        
        r1 = getDistFromPoints(localNodej,[x_LCP_ij,z_LCP_ij]);
        r2 = getDistFromPoints(localNodej1,[x_LCP_ij,z_LCP_ij]); 

        inducedVelocityU_local = (theta_2-theta_1)/(2*pi);
        inducedVelocityW_local = (1/(4*pi)) * log(r2^2/r1^2);
        
        [data.inducedVelocity.u(i,j),data.inducedVelocity.w(i,j)] = local2Global(inducedVelocityU_local,inducedVelocityW_local,j,mesh,'inducedVelocity');
        
        if (i ~= j)
            vectorA = [data.inducedVelocity.u(i,j),data.inducedVelocity.w(i,j)];
            vectorB = [cos(alpha_j), -sin(alpha_j)];

            data.influenceCoefficient(i,j) = dot(vectorA,vectorB);
        else
            data.influenceCoefficient(i,j) = -0.5;
        end
    end
    data.b (i) = dot(-Qinf,vector.tangent.cart(i,:));
    
end

    data.influenceCoefficient(elementBoundary,1) = 1;
    data.influenceCoefficient(elementBoundary,2:end-1) = 0;
    data.influenceCoefficient(elementBoundary,end) = 1;
    data.b (elementBoundary) = 0;


    data.vortexStrength = data.influenceCoefficient\data.b;

    data.vortexStrength(elementBoundary) = (data.vortexStrength(elementBoundary+1)+data.vortexStrength(elementBoundary-1))/2;
    
function mesh = getCircularMesh(r,nElem)

    
    mesh.nElem = nElem;
    mesh.nNode = nElem;

    mesh.elemList = 1:1:nElem;
    mesh.nodeList = mesh.elemList;

    mesh.connectMatrix = zeros(nElem,2);
    mesh.nodCoord.theta = zeros(nElem,1);  
    mesh.nodCoord.r = r; %1 = r, 2 = theta
    
    mesh.angularStep = 2*pi/nElem;

    for i = 1:1:(nElem)

        mesh.connectMatrix(i,1) = i;
        mesh.connectMatrix(i,2) = i+1;

        mesh.nodCoord.theta(i) = (i-1)*mesh.angularStep;
        [x,z] = cyl2cart(r,mesh.nodCoord.theta(i));
        mesh.nodCoord.cart(i,1) = x;
        mesh.nodCoord.cart(i,2) = z;


    end
        mesh.connectMatrix(end,2) = 1;
        
        % Code only for debuging!!!

        % deltaX = mesh.nodCoord.x(mesh.connectMatrix(:,2))-mesh.nodCoord.x(mesh.connectMatrix(:,1));
        % deltaz = mesh.nodCoord.z(mesh.connectMatrix(:,2))-mesh.nodCoord.z(mesh.connectMatrix(:,1));
        % 
        % mesh.ElemLength = sqrt(deltaX.^2 + deltaz.^2);


        deltaX = mesh.nodCoord.cart(2,1)-mesh.nodCoord.cart(1,1);
        deltaz = mesh.nodCoord.cart(2,2)-mesh.nodCoord.cart(1,2);

        mesh.ElemLength = sqrt(deltaX^2 + deltaz^2);

        mesh.controlCoord.cart(:,1) =  (mesh.nodCoord.cart(mesh.connectMatrix(:,2),1)+mesh.nodCoord.cart(mesh.connectMatrix(:,1),1))./2;
        mesh.controlCoord.cart(:,2) =(mesh.nodCoord.cart(mesh.connectMatrix(:,2),2)+mesh.nodCoord.cart(mesh.connectMatrix(:,1),2))./2;
        
        [~,mesh.controlCoord.theta] = cart2cyl(mesh.controlCoord.cart(:,1),mesh.controlCoord.cart(:,2));
        
        

end

function [r,theta] = cart2cyl (x,z,x0,z0) %ANGLES EN RADIANTS!!!

    if nargin < 3
        x0 = 0;
        z0 = 0;
    end

    x_rel = x-x0;
    z_rel = z-z0;

    r = sqrt(x_rel.^2 + z_rel.^2);
    theta = atan2(z_rel,x_rel);
end

function [x, z] = cyl2cart(r, theta, r0, theta0) %ANGLES EN RADIANTS
    % Asignar valores por defecto si no se pasan r0 z theta0
    if nargin < 3
        r0 = 0;
        theta0 = 0;
    end
    x_rel = r .* cos(theta);
    z_rel = r .* sin(theta);

    x0 = r0 .* cos(theta0);
    z0 = r0 .* sin(theta0);

    x = x_rel + x0;
    z = z_rel + z0;
end

function plotMesh(mesh)
    rVector = zeros(size(mesh.nodCoord.theta,1),1);
    rVector(1:end) = mesh.nodCoord.r;
    figure();
    
    polarplot (mesh.nodCoord.theta,rVector);
        
    figure();
    hold on
    plot(mesh.nodCoord.cart(:,1),mesh.nodCoord.cart(:,2))
    scatter(mesh.nodCoord.cart(:,1),mesh.nodCoord.cart(:,2),'red')
    scatter(mesh.controlCoord.cart(:,1),mesh.controlCoord.cart(:,2),'green')
    hold off
end
 
function vector = getNormalVector (mesh,vector)
    if nargin < 2
    end
    vector.normal.polar = [ones(mesh.nElem,1),mesh.controlCoord.theta];
    [X,Y] = cyl2cart(1,mesh.controlCoord.theta);
    vector.normal.cart = [X,Y];
end


function vector = getTangentlVector (mesh,vector)
    if nargin < 2
    end
    vector.tangent.polar = [ones(mesh.nElem,1),(mesh.controlCoord.theta) + ones(mesh.nElem,1).*pi/2];
    [X,Y] = cyl2cart(1,vector.tangent.polar(:,2));
    vector.tangent.cart = [X,Y];
end

function [xPan,zPan,alpha_j] = global2Local(x,z,numPan,mesh)

    nod_j0 = mesh.connectMatrix(numPan,1);
    nod_j1 = mesh.connectMatrix(numPan,1);
    
    coordNod_j0 = mesh.nodCoord.cart(nod_j0,:);
    coordNod_j1 = mesh.nodCoord.cart(nod_j1,:);
    
    alpha_j = getRelativeAngleFromVector(coordNod_j0,coordNod_j1);
    
    xPan = (x - coordNod_j0(1))*cos(alpha_j) - (z - coordNod_j0(2))*sin(alpha_j);
    zPan = (x - coordNod_j0(1))*sin(alpha_j) + (z - coordNod_j0(2))*cos(alpha_j);

end

function [x,z] = local2Global(xPan,zPan,numPan,mesh,type)

    nod_j0 = mesh.connectMatrix(numPan,1);
    nod_j1 = mesh.connectMatrix(numPan,1);
    
    coordNod_j0 = mesh.nodCoord.cart(nod_j0,:);
    coordNod_j1 = mesh.nodCoord.cart(nod_j1,:);
    
    alpha_j = getRelativeAngleFromVector(coordNod_j0,coordNod_j1);
    
    switch type
        case 'coords'

            x = coordNod_j0(1) + xPan*cos(alpha_j) + zPan*sin(alpha_j);
            z = coordNod_j0(2) - xPan*sin(alpha_j) + zPan*cos(alpha_j);
        case 'inducedVelocity' % xPan = uInduced; zPan = wInduced
            x = xPan*cos(alpha_j) + zPan*sin(alpha_j);
            z = xPan*sin(alpha_j) + zPan*cos(alpha_j);
    end
end

function alpha = getRelativeAngleFromVector (X,Y)
%Angle between X and Y (vectors)
    x = round(norm(X),10);
    y = round(norm(Y),10);
    
    alpha = acos(round(dot(X,Y),10)/(x*y));
end

function theta = getRelativeAngleFromPoint (P1,P2)

    dx = P1(1) - P2(1);
    dz = P1(2) - P2(2);
    theta = atan2(dz,dx);

end

function dist = getDistFromPoints (P1,P2)

    dx = P1(1) - P2(1);
    dz = P1(2) - P2(2);

    dist = sqrt(dx^2 + dz^2);
end
