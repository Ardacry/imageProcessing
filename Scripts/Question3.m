% This script takes the airplane graveyard image and identify each planes
% and color label them one by one by using rgb tresholding and
% morphological techniques.
% Author: Arda Kıray (21302072)

img = imread("airplane_graveyard.jpg");

% Grayscale tresholding
temp = rgb2gray(img);
temp = temp > 50 & temp < 230;

% Structural elements symmetrical with origin
str = [0,1,0;1,1,1;0,1,0];
str2 = [1,0,1;0,1,0;1,0,1];

% Closing operation
temp = erosion(temp,str);
temp = dilation(temp,str2);

temp = imcomplement(temp);

% red,green and blue bands of the original image imgr,imgg,imgb
imgr = img(:,:,1);
imgg = img(:,:,2);
imgb = img(:,:,3);

% Tresholding of the big blue planes and small planes rgb bands
img1 = (imgr > 160 & imgr < 200) & (imgg > 185 & imgg < 220) & (imgb > 230);
img2 = (imgr > 190 & imgr < 220) & (imgg > 195 & imgg < 230) & (imgb > 220);

% Dilation of extracted rgb bands to improve visibility
img1 = dilation(img1,str);
img2 = dilation(img2,str);

% Putting img1 and img2 together
img3 = img1 | img2;

% Closing operation
img3 = dilation(img3,str);
img3 = erosion(img3,str);

% Combining the result with first grayscale treshold
img4 = temp | img3;

% Closing operation
img4 = dilation(img4,str);
img4 = erosion(img4,str);

% Connected component labeling with shuffled 5 colors
cc = bwconncomp(img4);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

figure;
imshow(rgb)










    