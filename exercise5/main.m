%% Assignment 5 PCA
% Yorick de Boer & Lucas van Berkel
% 10786015, 10747958
clear;
load omni
%%
Xtraining = getImageFromCell( images, 1, 300);
Xtest = getImageFromCell( images, 301, 550 );

%%
% Training set 
d = 15;
[XmeanTrain, normalisedXtrain] = meanXNormalisedX(Xtraining);
[eigenVectorsTrain, eigenWaardenTrain] = getEigenvectors(normalisedXtrain, d);

%% preprocess testset
trainingMean = repmat(XmeanTrain, 1, 250); 
normalisedXtest = Xtest - trainingMean;

[eigenVectorsTest, eigenWaardenTest] = getEigenvectors(normalisedXtrain, d);
componentsTest = getPCAComponents(normalisedXtest, eigenVectorsTest, d);

%%
plot(eigenWaardenTrain)

%%
componentsTrain = getPCAComponents(normalisedXtrain, eigenVectorsTrain, d);

%%
vector = reshape(eigenVectorsTrain(:,1), 112, 150);
imshow(vector, [])

figure;
vector = reshape(eigenVectorsTrain(:,2), 112, 150);
imshow(vector, [])
figure;
vector = reshape(eigenVectorsTrain(:,10), 112, 150);
imshow(vector, [])

%%
idx = knnsearch(componentsTrain', componentsTest')

% accuracy
unit_threshold = 150;
correct = 0;
[length, ~] = size(idx)
for i=1:length
    train_image_pos = images{idx(i)}.position;
    test_image_pos = images{i + 300}.position;
    distance = sqrt(sum((train_image_pos - test_image_pos) .^ 2));
    if distance < unit_threshold
        correct = correct + 1;
    end
end
accuracy = correct / length

%%

figure;
imshow(images{2}.img, [])

figure;
imshow(images{5}.img, [])
