function [ accuracy ] = expirmentAComponents( images, d)
%Experiment funcion to measure the time vs the amount of componenents d
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

% KNN
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

