clear all;
im1 = single(rgb2gray(im2double(imread('nachtwacht1.jpg'))));
im2 = single(rgb2gray(im2double(imread('nachtwacht2.jpg'))));
[F1, D1] = vl_sift(im1);
[F2, D2] = vl_sift(im2);
[matches, scores] = vl_ubcmatch(D1, D2);
[~, length] = size(matches);
selF1 = zeros(4, length);
selF2 = zeros(4, length);
for i=1:length
    selF1(:,i)=F1(:,matches(1,i));
    selF2(:,i)=F2(:,matches(2,i));
end

xy = selF1(1:2,3:6);
xaya = selF2(1:2,3:6);

T = maketform('projective', xy', xaya');

[x,  y] = tformfwd(T,[1 size(im1,2)], [1 size(im1,1)]);

xdata = [min(1,x(1)) max(size(im2,2),x(2))];
ydata = [min(1,y(1)) max(size(im2,1),y(2))];
f12 = imtransform(im1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(im2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
subplot(1,1,1);
imshow(max(f12,f22));
