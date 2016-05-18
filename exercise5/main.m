%% Assignment 5 PCA
% Yorick de Boer & Lucas van Berkel
% 10786015, 10747958
clear;
load omni
%%
tempImage = images{1}.img;
[height, width ] = size(tempImage);
Xtraining = zeros(height*width, 300);
for i=1:300
    tempImage = images{i}.img;
    tempVector = reshape(tempImage, height*width, 1);
    Xtraining(:, i) = tempVector;
end
Xtest = zeros(height*width, length(images)-300);
for i=301:length(images)
    tempImage = images{i}.img;
    tempVector = reshape(tempImage, height*width, 1);
    Xtest(:, i-300) = tempVector;
end
clear i tempImage tempVector width height

clear Xtest
%%
[Xmean, normalisedX] = meanXNormalisedX(Xtraining);
eigenVectors = getEigenvectors(normalisedX, 20);

%%
trainingset = zeros(20, 300);
for i=1:300
    for j=1:20
        trainingset(j, i) = dot(normalisedX(:, i), eigenVectors(:, j));
    end
end