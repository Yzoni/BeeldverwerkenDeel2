function [ line, coordinates ] = line_through_points(points)
% returns:
%     line         - homogeneous  representation  of the least -square -fit
nohomo_points = points(1:2, :);
centroid = mean(nohomo_points, 2);
points_ = nohomo_points;
for i=1:length(nohomo_points)
    points_(:,i) = nohomo_points(:,i) - centroid;
end

newMatrix = points_ * points_';

[v, d] = eig(newMatrix);
max_eigvalue_col = find(max(d));

max_eigvector = v(max_eigvalue_col, :);
a = max_eigvector(2) / max_eigvector(1);

b = -centroid(1)*a + centroid(2);

point1_x = 0;
point1_y = b;
point2_x = centroid(1);
point2_y = centroid(2);

coordinates = [point1_x, point2_x, point1_y, point2_y];

line = cross([point1_x, point1_y, 1], [point2_x, point2_y, 1]);

end

