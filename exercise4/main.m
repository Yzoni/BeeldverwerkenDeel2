%% Yorick de Boer & Lucas van Berkel

%% INIT images
clear;
clc;

addpath('attachments');
im_shapes = im2double(rgb2gray(imread('shapes.png')));
im_box = im2double(rgb2gray(imread('box.png')));
im_szeliski = im2double(rgb2gray(imread('szeliski.png')));
im_billboard = im2double(rgb2gray(imread('billboard.png')));

%% Hough transforms
rows_shapes = 500;
cols_shapes = 500;
h_shapes = hough(im_shapes, [0.2, 0.8], rows_shapes, cols_shapes);
%h_box = hough(im_box, [0.1, 0.9], 100, 100);
h_szeliski = hough(im_szeliski, [0.2, 0.8], 100, 100);
%h_billboard = hough(im_billboard, [0.1, 0.9], 100, 100);

imtool(h_shapes, [0,80])
%imtool(h_box, [])
%imtool(h_szeliski, [])
%imtool(h_billboard, [])

%%  Finding the Lines as Local Maxima
[lines, coordinates] = houghlines(im_shapes, h_shapes, 130);

imshow(im_shapes)
hold on
for n=1:length(coordinates)
    line([coordinates(n,1),coordinates(n,2)],[coordinates(n,3),coordinates(n,4)]);
end
hold off