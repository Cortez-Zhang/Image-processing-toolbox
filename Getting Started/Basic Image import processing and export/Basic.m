close all; clear; clc
%read an image;

I=imread('test.jpg');
imshow(I)

% check how the image appears in workspace
whos I

% improve imgae contrast

I=rgb2gray(I);
imshow(I)


figure
imhist(I); % only works for grayscale images or binary images.

%first way
I1=histeq(I);
% figure
% imshow(I1)
% figure
% imhist(I1)

%second way
I2=imadjust(I);
% figure
% imshow(I2) %%seems the better way;
% figure
% imhist(I2)
%third way
I3=adapthisteq(I);
% figure
% imshow(I3)
% figure
% imhist(I3)

subplot(3,2,1), imshow(I1)
subplot(3,2,2), imhist(I1)

subplot(3,2,3), imshow(I2)
subplot(3,2,4), imhist(I2)

subplot(3,2,5), imshow(I3)
subplot(3,2,6), imhist(I3)

%write to disk

imwrite(I1,'I1.png');
imwrite(I2,'I2.png');
imwrite(I3,'I3.png');

%show the info

imfinfo('I1.png')
imfinfo('I2.png')
imfinfo('I3.png')




