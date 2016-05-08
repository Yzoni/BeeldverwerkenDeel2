function [ pts ] = points_of_line(points , line , epsilon)
%     points   - an  array  containing  all  points
%     line     - the  homogeneous  representation  of the  line
%     epsilon  - the  maximum  distance
% returns:
%     pts      - an  array of all  points  within  epsilon  of the  line

% Transform points to homogenous coordinates
points_h = [points, ones(size(points, 1), 1)];

% The perpendicular distance from a line to a point is given by the dot
% product.
distance = dot(points_h, line);

% Create an inlier mask
inlier_mask = abs(distance) < epsilon;

% Get all the inliers
pts = points(inlier_mask, :);

end

