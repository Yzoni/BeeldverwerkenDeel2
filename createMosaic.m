clear all;
im1 = single(rgb2gray(im2double(imread('nachtwacht1.jpg'))));
im2 = single(rgb2gray(im2double(imread('nachtwacht2.jpg'))));
[F1, D1] = vl_sift(im1);
[F2, D2] = vl_sift(im2);
[matches, scores] = vl_ubcmatch(D1, D2);
[~, length] = size(matches);
selF1 = zeros(4, length);
selF2 = zeros(4, length);

scores(2,:) = 1:length;
newMatches = zeros(2, length);
tempScores = scores;

for i=1:length
    [~, newLength] = size(tempScores);
    limit = 0;
    index = 0;
    for j=1:newLength
        if(tempScores(1,j)>limit)
            index = j;
            limit = tempScores(1,j);
        end
    end
    newMatches(:,i) = matches(:,index);
    tempScores(:,index) = [];
end

for i=1:length
    selF1(:,i)=F1(:,newMatches(1,i));
    selF2(:,i)=F2(:,newMatches(2,i));
end

figure
xy = selF1(1:2,1:4);
xaya = selF2(1:2,1:4);

P = createProjectionMatrix(xy', xaya')';
T = maketform('projective', P);

[x,  y] = tformfwd(T,[1 size(im1,2)], [1 size(im1,1)]);

xdata = [min(1,x(1)) max(size(im2,2),x(2))];
ydata = [min(1,y(1)) max(size(im2,1),y(2))];
f12 = imtransform(im1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(im2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
subplot(1,1,1);
imshow(max(f12,f22));