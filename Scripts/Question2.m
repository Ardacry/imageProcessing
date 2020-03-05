% This script reads the sonnet.png image and applies adaptive tresholding
% and morphological techniques to extract the text in the source image
% Author: Arda Kıray (21302072)

img = imread("sonnet.png");

% Adaptive treshold with neighborhood size 31
T = adaptthresh(img,"ForegroundPolarity","dark","NeighborhoodSize",31);

temp = imbinarize(img,T);

temp = imcomplement(temp); % taking the complement for changing whites and blacks

% str = origin symmetric structural element and str2
str = [0,1,0;1,1,1;0,1,0];
str2 = [1,1,0];

% Below operations extract the boundraies of the image
temp2 = erosion(temp,str);
temp3 = temp - temp2; 

% Closing operation
temp5 = dilation(temp3,str2);
temp5 = erosion(temp5,str2);

% Filling the holes and revert it back to its normal format
temp5 = dilation(temp5,str2);
temp5 = imcomplement(temp5);

figure;
imshow(temp5)








