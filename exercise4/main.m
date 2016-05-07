addpath('attachments');
im = im2double(rgb2gray(imread('shapes.png')));
h = hough(im, [0.1, 0.9], 100, 100);

