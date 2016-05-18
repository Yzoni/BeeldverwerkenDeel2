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
eigenVectors = getEigenvectors(normalisedX, 50);

%%
trainingset = zeros(50, 300);
for i=1:300
    for j=1:50
        trainingset(j, i) = dot(normalisedX(:, i), eigenVectors(:, j));
    end
end
%%
vector = reshape(eigenVectors(:,1), 112, 150);
imshow(vector, [])

figure;
vector = reshape(eigenVectors(:,2), 112, 150);
imshow(vector, [])
figure;
vector = reshape(eigenVectors(:,50), 112, 150);
imshow(vector, [])
