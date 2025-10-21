clear;clc;close all;

mesh = getCircularMesh(1,5);
plotMesh(mesh);
vector = getNormalVector (mesh)




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
        [x,y] = cyl2cart(r,mesh.nodCoord.theta(i));
        mesh.nodCoord.x(i) = x;
        mesh.nodCoord.y(i) = y;


    end
        mesh.connectMatrix(end,2) = 1;
        
        % Code only for debuging!!!

        % deltaX = mesh.nodCoord.x(mesh.connectMatrix(:,2))-mesh.nodCoord.x(mesh.connectMatrix(:,1));
        % deltaY = mesh.nodCoord.y(mesh.connectMatrix(:,2))-mesh.nodCoord.y(mesh.connectMatrix(:,1));
        % 
        % mesh.ElemLength = sqrt(deltaX.^2 + deltaY.^2);


        deltaX = mesh.nodCoord.x(2)-mesh.nodCoord.x(1);
        deltaY = mesh.nodCoord.y(2)-mesh.nodCoord.y(1);

        mesh.ElemLength = sqrt(deltaX^2 + deltaY^2);

        mesh.controlCoord.x =  (mesh.nodCoord.x(mesh.connectMatrix(:,2))+mesh.nodCoord.x(mesh.connectMatrix(:,1)))./2;
        mesh.controlCoord.y =(mesh.nodCoord.y(mesh.connectMatrix(:,2))+mesh.nodCoord.y(mesh.connectMatrix(:,1)))./2;
        
        [~,mesh.controlCoord.theta] = cart2cyl(mesh.controlCoord.x,mesh.controlCoord.y);
        
        

end

function [r,theta] = cart2cyl (x,y,x0,y0) %ANGLES EN RADIANTS!!!

    if nargin < 3
        x0 = 0;
        y0 = 0;
    end

    x_rel = x-x0;
    y_rel = y-y0;

    r = sqrt(x_rel.^2 + y_rel.^2);
    theta = atan2(y_rel,x_rel);
end

function [x, y] = cyl2cart(r, theta, r0, theta0) %ANGLES EN RADIANTS
    % Asignar valores por defecto si no se pasan r0 y theta0
    if nargin < 3
        r0 = 0;
        theta0 = 0;
    end
    x_rel = r .* cos(theta);
    y_rel = r .* sin(theta);

    x0 = r0 .* cos(theta0);
    y0 = r0 .* sin(theta0);

    x = x_rel + x0;
    y = y_rel + y0;
end

function plotMesh(mesh)
    rVector = zeros(size(mesh.nodCoord.theta,1),1);
    rVector(1:end) = mesh.nodCoord.r;
    figure();
    
    polarplot (mesh.nodCoord.theta,rVector);
        
    figure();
    hold on
    plot(mesh.nodCoord.x,mesh.nodCoord.y)
    scatter(mesh.nodCoord.x,mesh.nodCoord.y,'red')
    scatter(mesh.controlCoord.x,mesh.controlCoord.y,'green')
    hold off
end
 
function vector = getNormalVector (mesh,vector)
    if nargin < 2
    end
    vector.normal.polar = [ones(mesh.nElem,1),mesh.controlCoord.theta.'];
    [X,Y] = cyl2cart(1,mesh.controlCoord.theta);
    vector.normal.cart = [X;Y].';
end