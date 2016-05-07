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
h_shapes = hough(im_shapes, [0.1, 0.9], 100, 100);
%h_box = hough(im_box, [0.1, 0.9], 100, 100);
%h_szeliski = hough(im_szeliski, [0.1, 0.9], 100, 100);
%h_billboard = hough(im_billboard, [0.1, 0.9], 100, 100);

imtool(h_shapes, [])
%imtool(h_box, [])
%imtool(h_szeliski, [])
%imtool(h_billboard, [])