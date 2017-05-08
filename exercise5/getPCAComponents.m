function [ components ] = getPCAComponents( normalisedX, eigenVectors, d )
% Calculates the components
%   normalisedX, array containing the imagevectors normalised with the mean
%   eigenVectors, array containing the eigenvectors of the covariancematrix
%   d, number of components
[~, width] = size(normalisedX);

components = zeros(d, width);
for i=1:width
    for j=1:d
        components(j, i) = dot(normalisedX(:, i), eigenVectors(:, j));
    end
end


end

