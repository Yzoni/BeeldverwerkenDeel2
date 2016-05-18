%% Assignment 5 PCA
% Yorick de Boer & Lucas van Berkel
% 10786015, 10747958
clear;
load omni
%%
Xtraining = getImageFromCell( images, 1, 300);

%%
d = 10;

[Xmean, normalisedX] = meanXNormalisedX(Xtraining);
[eigenVectors, eigenWaarden] = getEigenvectors(normalisedX, d);
%%
plot(eigenWaarden)
%%
components = getPCAComponents(normalisedX, eigenVectors, d);
%%
vector = reshape(eigenVectors(:,1), 112, 150);
imshow(vector, [])

figure;
vector = reshape(eigenVectors(:,2), 112, 150);
imshow(vector, [])
figure;
vector = reshape(eigenVectors(:,10), 112, 150);
imshow(vector, [])
