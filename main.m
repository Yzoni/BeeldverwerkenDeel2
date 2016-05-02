%% INIT
clear
clc

% Load images
im1 = rgb2gray(im2single(imread('nachtwacht1.jpg')));
im2 = rgb2gray(im2single(imread('nachtwacht2.jpg')));

%% 2 projectivity
demo_mosaic;

%% 3.1: Visualizing the matches
[F1, D1] = vl_sift(im1);
[F2, D2] = vl_sift(im2);
[matches, scores] = vl_ubcmatch(D1, D2);

% Coordinates from matching descriptors
matches_im1 = matches(1,:);
matches_im1_coor = F1(1:2,matches_im1);

matches_im2 = matches(2,:);
matches_im2_coor = F2(1:2,matches_im2);

subplot(1, 2, 1);
imshow(im1);
title('nachtwacht1');
for i = 1:length(matches_im1_coor)
    x = matches_im1_coor(1, i);
    y = matches_im1_coor(2,i);
    s = 10;
    rectangle('Position', [x-s/2, y-s/2, s, s], 'EdgeColor', 'red');
    text(x+s/2, y+s/2, sprintf('%02d',i), 'Color', 'red');
end

subplot(1, 2, 2);
imshow(im2);
title('nachtwacht2');
for i = 1:length(matches_im2_coor)
    x = matches_im2_coor(1, i);
    y = matches_im2_coor(2,i);
    s = 10;
    rectangle('Position', [x-s/2, y-s/2, s, s], 'EdgeColor', 'red');
    text(x+s/2, y+s/2, sprintf('%02d',i), 'Color', 'red');
end


%% 3.2: Project



%% 4 RANSAC
[F1, D1] = vl_sift(im1);
[F2, D2] = vl_sift(im2);
[matches, scores] = vl_ubcmatch(D1, D2);

% Coordinates from matching descriptors
matches_im1 = matches(1,:);
matches_im1_coor = F1(1:2,matches_im1);

matches_im2 = matches(2,:);
matches_im2_coor = F2(1:2,matches_im2);

% RANSAC projection matrix
P = ransacProjection(matches_im1_coor, matches_im2_coor, 4, 20, 1, 0.3);

T = maketform('projective', P);

[x,  y] = tformfwd(T,[1 size(im1,2)], [1 size(im1,1)]);

xdata = [min(1,x(1)) max(size(im2,2),x(2))];
ydata = [min(1,y(1)) max(size(im2,1),y(2))];
f12 = imtransform(im1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(im2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
subplot(1,1,1);
imshow(max(f12,f22));

