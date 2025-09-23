clear; clc;close all


geometry.xLength = 4;
geometry.yLength = 3;
geometry.horizontalElementCount = 4;
geometry.verticalElementCount = 3;

meshType = "uniform";

mesh = deffineMesh(geometry,meshType);
mesh = createHalo(mesh);

meshPlotter(mesh,"halo");











function mesh = deffineMesh(geometry,meshType)
    

    verifyCodeError ('zero',geometry)


    xLength = geometry.xLength;
    yLength = geometry.yLength;

    n = geometry.horizontalElementCount;
    m = geometry.verticalElementCount;

    switch meshType
        case "uniform"    
            deltaX = xLength/n;
            deltaY = yLength/m;

        case "irregular"
            
            deltaX = geometry.deltaX;
            deltaY = geometry.deltaY;

        otherwise

            verifyCodeError ('unconsidered',meshType)
    end
    % We always set the origin of coordenates to left bottom node
   

    xCenters = deltaX/2:deltaX:xLength - deltaX/2;
    yCenters = deltaY/2:deltaY:yLength - deltaY/2;  
    
    [X,Y] = meshgrid(xCenters, yCenters);
    
    mesh.centralNodCoord(:,1) = X(:);
    mesh.centralNodCoord(:,2) = Y(:);


    mesh.deltaX = deltaX;
    mesh.deltaY = deltaY;
    mesh.xLength = xLength;
    mesh.yLength = yLength;

    mesh.numNodes = [1,1:n*m];
    mesh.n = n;
    mesh.m = m;
 
    mesh.fullNodCoordMatrix(:,:,1) = reshape(X', n, m);  % x-coordinates
    mesh.fullNodCoordMatrix(:,:,2) = reshape(Y', n, m);  % y-coordinates
end

function mesh = createHalo (mesh)
    
    deltaX = mesh.deltaX;
    deltaY = mesh.deltaY;
    xLength = mesh.xLength;
    yLength = mesh.yLength;

    n = mesh.n +2;
    m = mesh.m +2;
    
    xCenters = -deltaX/2:deltaX:(xLength+deltaX/2);
    yCenters = -deltaY/2:deltaY:(yLength+deltaY/2);  
    
    [X,Y] = meshgrid(xCenters, yCenters);
    
    mesh.centralNodCoordHalo(:,1) = X(:);
    mesh.centralNodCoordHalo(:,2) = Y(:);

    mesh.fullNodCoordMatrixWitHalo(:,:,1) = reshape(X', n, m);  % x-coordinates
    mesh.fullNodCoordMatrixWitHalo(:,:,2) = reshape(Y', n, m);  % y-coordinates
end




function coord = getAverageNodeFromCentralNode(mesh,node1Index,node2Index)
% Get the X and Y coordinates of the average between two inputs
    coord.x = (mesh.fullNodCoordMatrix(node1Index,1) + mesh.fullNodCoordMatrix(node2Index,1))/2;
    coord.y = (mesh.fullNodCoordMatrix(node1Index,2) + mesh.fullNodCoordMatrix(node2Index,2))/2;

end

function meshPlotter (mesh,type)

    switch type
        case "mesh"
            figure ();
            scatter(mesh.centralNodCoord(:,1),mesh.centralNodCoord(:,2));
            grid on;
        case "halo"
            figure ();
            hold on
            scatter(mesh.centralNodCoordHalo(:,1),mesh.centralNodCoordHalo(:,2),"red");
            scatter(mesh.centralNodCoord(:,1),mesh.centralNodCoord(:,2),"blue")
            hold off
            grid on;
    end
end


function verifyCodeError (type,data)
    switch type
        case "zero"
            fn = fieldnames(data);
            for i = 1:numel(fn)
                value = data.(fn{i});
                if value == 0
                    error('Variable %s has invalid value: %g', fn{i}, value);
                end
            end

        case "unconsidered"
            error ("unconsidered option set");
    end
end