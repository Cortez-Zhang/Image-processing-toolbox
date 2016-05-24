close all; clear; clc
%read an image;

I=imread('rice.jpg');
I=rgb2gray(I);
imshow(I)

% preprocess
 
background = imopen(I,strel('disk',15));
imshow(background)

figure
surf(double(background(1:8:end,1:8:end))),zlim([0,255]);
set(gca,'ydir','reverse');


%subtract the background 
figure
I1=I-background;
imshow(I1)

% ----------------------
figure
surf(double(I(1:8:end,1:8:end))),zlim([0,255]);
set(gca,'ydir','reverse');

figure
surf(double(I1(1:8:end,1:8:end))),zlim([0,255]);
set(gca,'ydir','reverse');

% ----------------------
%increse the contrast
figure
I2=imadjust(I1);
imshow(I2)

% binary image
figure
level=graythresh(I2);
bw1=im2bw(I2,level);
bw=bwareaopen(bw1,50); % remove small objects from binary image.
imshow(bw)

figure 
result=bw1-bw;
imshow(result)

%analysis
cc=bwconncomp(bw,4)
cc.NumObjects

grain = false(size(bw));% logical zeros.
grain(cc.PixelIdxList{50}) = true;
figure
imshow(grain)


%visualize the connected components
figure
labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label)
figure
RGB_label1 = label2rgb(labeled, @summer, 'r', 'shuffle');
imshow(RGB_label1)

%Compute the area of each object 
graindata = regionprops(cc, 'basic')

graindata(50).Area

%Create a vector grain_areas to hold the area measurement of each object (rice grain).
figure
grain_areas = [graindata.Area];
%smallest rice
[min_area, idx] = min(grain_areas)
grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
imshow(grain);

%using the hist to creat histogram

nbins = 20;
figure
hist(grain_areas, nbins)
title('Histogram of Rice Grain Area');






