function [ eigenVectors, eigenWaarden ] = getEigenvectors( normalisedX, d )
% Calculates the eigenvectors of the covarianceMatrix and returns the
% vectors with the d-highest eigenwaarden
%   X: matrix containing image-vectors
%   d: number of eigenvectors to be returned

Q = normalisedX*normalisedX';

[eigenVectors, eigenWaarden] = eigs(Q, d);
eigenWaarden = diag(eigenWaarden);
end

