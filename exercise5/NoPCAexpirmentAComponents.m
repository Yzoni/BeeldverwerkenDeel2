function [ accuracy ] = expirmentAComponents(images)
%Experiment function used to measure the time the image comparison takes withouth
% PCA
Xtraining = getImageFromCell( images, 1, 300);
Xtest = getImageFromCell( images, 301, 550 );

% KNN
idx = knnsearch(Xtraining', Xtest');

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

