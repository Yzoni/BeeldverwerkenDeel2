function [ match ] = checkSet( testSet, randomInteger )
% Picks one element from set, calculates second best match
[~, length] = size(testSet);
toBeSearched = testSet(:, randomInteger);
match = 0;
minDistance = 10^10000;

for i=1:length
    if(i==randomInteger)
        continue;
    end
    tempDistance = sqrt(dot((testSet(:,i) - toBeSearched), (testSet(:,i) - toBeSearched)));
    if(tempDistance < minDistance)
        minDistance = tempDistance;
        match = i;
    end
end
end

