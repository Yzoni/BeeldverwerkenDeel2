%% Assignment 5 PCA
% Yorick de Boer & Lucas van Berkel
% 10786015, 10747958
clear;
load omni
%%
Xtraining = getImageFromCell( images, 1, 300);

%%
d = 50;

[Xmean, normalisedX] = meanXNormalisedX(Xtraining);
[eigenVectors, eigenWaarden] = getEigenvectors(normalisedX, d);
%%
plot(eigenWaarden)
title('First 50 eigenwaarden and their values')
ylabel('Value of eigenwaarde')
xlabel('Number of eigenwaarde')
components = getPCAComponents(normalisedX, eigenVectors, 15);
%%
for i=1:9
    vector = reshape(eigenVectors(:,i), 112, 150);
    imtool(vector , [-0.03 0.03])
end

%%
[~, length] = size(components);
randomInteger = floor(rand()*length);
disp(' ');
tic;
[match1] = checkSet(components, randomInteger);
toc;
disp('Using PCA image detection, we found :');
disp(match1);
tic;
[match2] = checkSet(Xtraining, randomInteger);
toc;
disp('Using naive image detection, we found :');
disp(match2);