function [ P ] = ransacProjection( coor1, coor2, n, k, t, d )
%RANSAC Finds the transformation matrix that fits the data best
%   coor1 & coor2 = coordinate matches
%   n = minimum number of data values required to fit the model
%   k = the maximum number of iterations allowed in the algorithm
%   t = a threshold value for determining when a data point fits a model
%   d = the number of close data values required to assert that a model 
%       fits well to data as percentage
%
%   P = the projection matrix

total_error = inf;

for i = 1:k
    % Get n random coordinates from all coordinates
    random_indices = randi(size(coor1, 2), 1, n);
    [P_temp, error_temp] = ransacCreateModel(coor1, coor2, random_indices);
    
    % Determine inlier count by comparing the error with the error 
    % threshold t, add to inlier indices vector.
    count_inlier = 0;
    count_all = 0;
    inlier_indices = [];
    for j = 1:length(error_temp)
        if error_temp(j) <= t
            count_inlier = count_inlier + 1;
            inlier_indices(end+1) = j;
        end
        count_all = count_all + 1;
    end
    percentage_inlier = count_inlier / count_all;
    
    % If inlier threshold is met, recreate model
    if percentage_inlier > d
        % Recreate model
        [P_inlier, error_temp] = ransacCreateModel(coor1, coor2, inlier_indices);
        
        % If total error is smaller than previous, new projection matrix found
        total_error_temp = sum(error_temp);
        if total_error_temp < total_error
            P = P_inlier;
            total_error = total_error_temp;
        end
    end
end

