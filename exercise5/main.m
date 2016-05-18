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
d = 50;
[XmeanTrain, normalisedXtrain] = meanXNormalisedX(Xtraining);
[eigenVectorsTrain, eigenWaardenTrain] = getEigenvectors(normalisedXtrain, d);
componentsTrain = getPCAComponents(normalisedXtrain, eigenVectorsTrain, d);

%%
plot(eigenWaardenTrain)
title('First 50 eigenwaarden and their values')
ylabel('Value of eigenwaarde')
xlabel('Number of eigenwaarde')

for i=1:9
    vector = reshape(eigenVectorsTrain(:,i), 112, 150);
    imtool(vector , [-0.03 0.03])
end

%%
[height, length] = size(componentsTrain);
randomInteger = floor(rand()*length);
disp(' ');
tic;
[match1] = checkSet(componentsTrain, randomInteger);
toc;
disp('Number of components:');
disp(height)
disp('Using PCA image detection, we found:');
disp(match1);
tic;
[match2] = checkSet(Xtraining, randomInteger);
toc;
disp('Using naive image detection, we found:');
disp(match2);

%% preprocess test set data
trainingMean = repmat(XmeanTrain, 1, 250); 
normalisedXtest = Xtest - trainingMean;

% Create testset data
componentsTest = getPCAComponents(normalisedXtest, eigenVectorsTrain, d);

%%
idx = knnsearch(componentsTrain', componentsTest');

% accuracy
unit_threshold = 150;
correct = 0;
[length, ~] = size(idx);
for i=1:length
    train_image_pos = images{idx(i)}.position;
    test_image_pos = images{i + 300}.position;
    distance = sqrt(sum((train_image_pos - test_image_pos) .^ 2));
    if distance < unit_threshold
        correct = correct + 1;
    end
end
accuracy = correct / length;
