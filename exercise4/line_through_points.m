function [ line, coordinates ] = line_through_points(points, im_shapes)
% returns:
%     line         - homogeneous  representation  of the least -square -fit
nohomo_points = points(1:2, :);
centroid = mean(nohomo_points, 2);
points_ = nohomo_points;
for i=1:length(nohomo_points)
    points_(:,i) = nohomo_points(:,i) - centroid;
end

newMatrix = points_ * points_';

[v, ~] = eig(newMatrix);

max_eigVector = v(2,:);

a = max_eigVector(2) / max_eigVector(1);

b = -centroid(1)*a + centroid(2);

[height, ~] = size(im_shapes);

point1_x = 0;
point1_y = b;
point2_x = height;
point2_y = a*height + b;

coordinates = [point1_x, point2_x, point1_y, point2_y];

line = cross([point1_y; point1_x; 1], [point2_y; point2_x; 1]);

end

