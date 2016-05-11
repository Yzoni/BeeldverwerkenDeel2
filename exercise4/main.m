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
[h_shapes, edges_shapes] = hough(im_shapes, [0.2, 0.8], rows_shapes, cols_shapes);
%h_box = hough(im_box, [0.1, 0.9], cols_shapes, cols_shapes);
h_szeliski = hough(im_szeliski, [0.2, 0.8], rows_shapes, cols_shapes);
%h_billboard = hough(im_billboard, [0.1, 0.9], cols_shapes, cols_shapes);

%imtool(h_shapes, [0,80])
%imtool(h_box, [0,80])
%imtool(h_szeliski, [0,80])
%imtool(h_billboard, [0,80])

%%  Finding the Lines as Local Maxima
[lines, coordinates] = houghlines(im_shapes, h_shapes, 130);

imshow(im_shapes)
hold on
% for n=1:length(coordinates)
n = 2;   
line([coordinates(n,1),coordinates(n,2)],[coordinates(n,3),coordinates(n,4)]);
% end
hold off;
[x, y] = find(edges_shapes);
X = vertcat(x', y', ones(1, length(x)));

figure;
imshow(im_shapes)
pointofline = points_of_line(X, lines(n,:), 0.01);
pointofline = pointofline(1:2,:);
hold on;
plot(pointofline(2,:),pointofline(1,:),'go');

hold off;

[lineshizzle, coordinates] = line_through_points(pointofline, im_shapes);
figure;
imshow(im_shapes)
hold on
line([coordinates(1,3),coordinates(1,4)],[coordinates(1,1),coordinates(1,2)]);
hold off