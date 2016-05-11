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

%% Only houghline
[lines, coordinates] = houghlines(im_shapes, h_shapes, 125);
imshow(im_shapes)
hold on
for n=1:length(coordinates)
    line([coordinates(n,1),coordinates(n,2)],[coordinates(n,3),coordinates(n,4)]);
end
hold off;

%% points of line
[x, y] = find(edges_shapes);
X = vertcat(x', y', ones(1, length(x)));

figure;
imshow(im_shapes)

hold on;
for n=1:length(lines)
    pointofline = points_of_line(X, lines(n,:), 0.01);
    pointofline = pointofline(1:2,:);
    plot(pointofline(2,:), pointofline(1,:),'go');
end
hold off;

%% Total square
figure;
imshow(im_shapes)
hold on
[lineshizzle, coordinates] = line_through_points(pointofline, im_shapes);
line([coordinates(1,3),coordinates(1,4)],[coordinates(1,1),coordinates(1,2)]);
hold off


%% 6 Using the Lines

% Implementation of getting the intersection of two lines
% LINE 1
n = 2;
[lines1, coordinates] = houghlines(im_shapes, h_shapes, 130);
% points of line
[x, y] = find(edges_shapes);
X = vertcat(x', y', ones(1, length(x)));
pointofline = points_of_line(X, lines1(n,:), 0.01);
pointofline = pointofline(1:2,:);
% Total square
[line1, coordinates1] = line_through_points(pointofline, im_shapes);

% LINE 2
n = 5;
[lines2, coordinates] = houghlines(im_shapes, h_shapes, 130);
% points of line
[x, y] = find(edges_shapes);
X = vertcat(x', y', ones(1, length(x)));
pointofline = points_of_line(X, lines2(n,:), 0.01);
pointofline = pointofline(1:2,:);
% Total square
[line2, coordinates2] = line_through_points(pointofline, im_shapes);

% Intersection of lines
intersection = cross([line1(2, 1); line1(1, 1); line1(3, 1)], [line2(2, 1); line2(1, 1); line2(3, 1)])

% Normalize
intersection = intersection ./ sqrt(intersection(1)^2 + intersection(2)^2);
intersection = intersection ./ intersection(3);

figure;
imshow(im_shapes)
hold on;
% intersecting lines
line([coordinates1(1,3),coordinates1(1,4)],[coordinates1(1,1),coordinates1(1,2)]);
line([coordinates2(1,3),coordinates2(1,4)],[coordinates2(1,1),coordinates2(1,2)]);

%point
plot(intersection(2,1), intersection(1,:),'r*');
hold off;



