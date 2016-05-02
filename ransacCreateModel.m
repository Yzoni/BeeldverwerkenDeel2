function [ P, error_vector ] = ransacCreateModel( coor1, coor2, indices )
%RANSACCREATEMODEL Creates a model for ransac main function
%   Detailed explanation goes here

    indexed_coor1 = coor1(:,indices);
    indexed_coor2 = coor2(:,indices);

    % Create projection matrix
    P = createProjectionMatrix(indexed_coor1', indexed_coor2');
    
    % Create homogenous coordinates
    h_coor1 = [coor1; ones(1, size(coor1, 2))];
    
    % Do projection for all points
    h_projected_coor1 = P * h_coor1;
    
    % Normalize error

    % Remove last row from homogenous coordinate system
    projected_coor1 = h_projected_coor1(1:2,:);
    
    % Calculate error (euclidean pixel distance)
    error_vector = pdist2(coor2', projected_coor1', 'euclidean');
    error_vector = diag(error_vector);

end

