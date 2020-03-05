% This script takes the 4 different frames of two surveillance cameras, one
% at the station and another at the copy machine room. It detects the human
% as a point of interest and extracts them by using binary image processing
% techniques.
% Author: Arda Kıray (21302072)

%% First video sequence(station) elements initilization 
backgroundc = imread("c0.png");
c1 = imread("c1.png");
c2 = imread("c2.png");
c3 = imread("c3.png");

% Gray scale transformation of each frame
c0g = rgb2gray(backgroundc);
c1g = rgb2gray(c1);
c2g = rgb2gray(c2);
c3g = rgb2gray(c3);

% Background subtraction of each frame
f1 = c0g - c1g;
f2 = c0g - c2g;
f3 = c0g - c3g;

%% Frame 2 detection, detected element in b1
b1 = imbinarize(f1);

% Structuring element
str = strel("disk",3);
str = str.getnhood();

% Opening operation
b1 = erosion(b1,str);
b1 = dilation(b1,str);

% Closing operation
b1 = dilation(b1,str);
b1 = erosion(b1,str);

% Connected component labeling with white background
cc = bwconncomp(b1);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

b1 = rgb;

figure;
imshow(b1)

%% Frame 3 detection, detected elements in b2

% Structuring element
str2 = strel("square",3);
str2 = str2.getnhood();

% Binary tresholding to [65,255]
temp = f2 < 20;
temp = imcomplement(temp);
temp2 = f2 < 35;
temp2 = temp - temp2;
temp3 = f2 < 65;
temp3 = temp2 - temp3;

% Opening operation
b2 = erosion(temp3,str2);
b2 = dilation(b2,str2);

% Connected component labeling with white background
cc = bwconncomp(b2);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

b2 = rgb;

figure;
imshow(b2)

%% Frame 4 detection, detected elements in b3

% Structuring element
str3 = strel("square",3);
str3 = str3.getnhood();

% Binary thresholding to select the closest two as clear as possible
ex = f3 > 30 & f3 < 90;
ex2 = f3 > 70;
ex3 = ex2 - ex;

% Opening operation
ex3 = erosion(ex3,str3);
ex3 = dilation(ex3,str3);

% Closing operation
ex3 = dilation(ex3,str3);
b3 = erosion(ex3,str3);

% Connected component labeling with white background
cc = bwconncomp(b3);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

b3 = rgb;

figure;
imshow(b3)

%% Second video sequence elements initilizations
backgroundcc = imread("cc0.png");
cc1 = imread("cc1.png");
cc2 = imread("cc2.png");
cc3 = imread("cc3.png");

% Grayscale transformations of each image
cc0g = rgb2gray(backgroundcc);
cc1g = rgb2gray(cc1);
cc2g = rgb2gray(cc2);
cc3g = rgb2gray(cc3);

% Background subtraction of each image
cf1 = cc0g - cc1g;
cf2 = cc0g - cc2g;
cf3 = cc0g - cc3g;

%% Frame 1 detection, detected elements in b4

% Structural element 1
str4 = strel("square", 3);
str4 = str4.getnhood();

% Structural element 2
str5 = strel("square",5);
str5 = str5.getnhood();

% Grayscale thresholding
temp = cf1 > 60;
temp2 = cf1 > 40 & cf1 < 70;
temp3 = temp & temp2;
temp4 = cf1 > 95;
temp4 = temp4 | temp3;
temp5 = cf1 > 45 & cf1 < 75;
temp5 = temp4 | temp5;

% Opening operation
temp5 = erosion(temp5,str4);
temp5 = dilation(temp5,str4);

% Closing operation
temp5 = dilation(temp5,str4);
temp5 = erosion(temp5,str4);

temp5 = dilation(temp5,str4);
temp5 = dilation(temp5,str4);

b4 = temp5;

% Connected component labeling with white background
cc = bwconncomp(b4);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

b4 = rgb;

figure;
imshow(b4)

%% Frame 2 detection, detected elements in b5

%Structuring element
str6 = strel("disk",3);
str6 = str6.getnhood();

% Grayscale threshold
temp = cf2 > 80;

% Opening operation
temp2 = erosion(temp,str6);
temp2 = dilation(temp2,str6);

% Closing operation
temp2 = dilation(temp2,str6);
temp2 = erosion(temp2,str6);

temp2 = dilation(temp2,str6);
temp2 = dilation(temp2,str6);
temp2 = dilation(temp2,str6);

% Opening operation
temp2 = erosion(temp2,str6);
temp2 = dilation(temp2,str6);

% Connected component labeling with white background
cc = bwconncomp(temp2);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

b5 = rgb;

figure;
imshow(b5)

%% Frame 3 detection, detected elements in b6

% Structuring element
str7 = strel("disk",3);
str7 = str7.getnhood();

% Grayscale tresholding
temp = cf3 > 60;
temp2 = cf3 < 60 & cf3 > 50;
temp3 = temp | temp2;

% Opening operation
temp3 = erosion(temp3,str7);
temp3 = dilation(temp3,str7);

% Closing operation
temp3 = dilation(temp3,str7);
temp3 = erosion(temp3,str7);

temp3 = dilation(temp3,str7);
temp3 = dilation(temp3,str7);

% Connected component labeling with white background
cc = bwconncomp(temp3);
L = labelmatrix(cc);
rgb = label2rgb(L,"jet","w",'shuffle');

b6 = rgb;

figure;
imshow(b6)









