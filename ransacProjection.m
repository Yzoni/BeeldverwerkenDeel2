function [ P ] = ransacProjection( coor1, coor2, n, k, t, d )
%RANSAC Finds the transformation matrix that fits the data best
%   coor1 & coor2 = coordinate matches
%   n = minimum number of data values required to fit the model
%   k = the maximum number of iterations allowed in the algorithm
%   t = a threshold value for determining when a data point fits a model
%   d = the number of close data values required to assert that a model 
%       fits well to data as percentage
%
%   bestfit = the projection matrix

total_error = inf;

for i = 1:k
    % Get random n coordinates from all coordinates
    random_indices = randi(size(coor1, 2), 1, n);
    random_coor1 = coor1(:,random_indices);
    random_coor2 = coor2(:,random_indices);
        
    % Calculate coordinates from projection
    % Create homogenous coordinates nescecary for the projection
    h_r_coor1 = [random_coor1; ones(1, size(random_coor1, 2))];
    
    % Create projection matrix (the model)
    P_temp = createProjectionMatrix(random_coor1, random_coor2);
    
    % Do projection for all points
    h_projected_coor1 = P_temp * h_r_coor1;
    projected_coor1 = h_projected_coor1(1:2,:);
    
    % Calculate error (euclidean pixel distance)
    error_temp = pdist2(random_coor2', projected_coor1', 'euclidean');
    error_temp = diag(error_temp);
    
    % Normalize error
    % TO
    
    % Determine inlier count by comparing the error with the error 
    % threshold t
    count_inlier = 0;
    count_all = 0;
    for j = 1:length(h_r_coor1)
        if error_temp(j) <= t;
            count_inlier = count_inlier + 1;
        end
        count_all = count_all + 1;
    end
    percentage_inlier = count_inlier / count_all;
    
    % If total error is smaller than previous, new projection matrix found
    total_error_temp = sum(error_temp);
    if percentage_inlier > d && total_error_temp < total_error
        P = P_temp;
        total_error = total_error_temp;
    end
end

