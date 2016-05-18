function [ set ] = getImageFromCell( images, beginIndex, endIndex )
% Extracts images from cell array
%   images, the cell array
%   begin, index to start extracting
%   end, index to end extracting

tempImage = images{1}.img;
[height, width ] = size(tempImage);

set = zeros(height*width, endIndex-beginIndex);
for i=beginIndex:endIndex
    tempImage = images{i}.img;
    tempVector = reshape(tempImage, height*width, 1);
    set(:, i) = tempVector;
end


end

