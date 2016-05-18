function [ accuracy ] = expirmentAComponents( images, d)
%EXPIRMENTACOMPONENTS Summary of this function goes here
%   Detailed explanation goes here
Xtraining = getImageFromCell( images, 1, 300);
Xtest = getImageFromCell( images, 301, 550 );

[XmeanTrain, normalisedXtrain] = meanXNormalisedX(Xtraining);
[eigenVectorsTrain, eigenWaardenTrain] = getEigenvectors(normalisedXtrain, d);
componentsTrain = getPCAComponents(normalisedXtrain, eigenVectorsTrain, d);

% preprocess test set data
trainingMean = repmat(XmeanTrain, 1, 250); 
normalisedXtest = Xtest - trainingMean;

% Create testset data
componentsTest = getPCAComponents(normalisedXtest, eigenVectorsTrain, d);

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

end

