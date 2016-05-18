function [ Xmean, normalisedX ] = meanXNormalisedX( X )
% Calculates Xmean and the normalised X matrix
%   X, array containing all imagevectors
Xmean = mean(X, 2);
[height, length] = size(X);
normalisedX = zeros(height, length);
for i=1:length
    normalisedX(:,i) = X(:,i)-Xmean;
end

end

