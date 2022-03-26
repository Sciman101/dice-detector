RGB = imread("test/1.jpg");

wavelength = 2.^(0:5) * 4;
orientation = 0:45:135;
g = gabor(wavelength,orientation);

% Convert to grayscale
I = im2gray(im2single(RGB));
gabormag = imgaborfilt(I,g);

% Smooth each image
for i=1:length(g)
    sigma = 0.5*g(i).Wavelength;
    gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma);
end
%montage(gabormag,"Size",[4 6]);

nrows=size(RGB,1);
ncols=size(RGB,2);
[X,Y] = meshgrid(1:ncols,1:nrows);

featureSet = cat(3,I,gabormag,X,Y);
L2 = imsegkmeans(featureSet,2,"NormalizeInput",true);
C = labeloverlay(RGB,L2);
imshow(C);


%[L,Centers] = imsegkmeans(I,3);
%B = labeloverlay(I,L);
%imshow(B);
%title("Labeled Image");