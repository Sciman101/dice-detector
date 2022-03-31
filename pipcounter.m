A = imread('test/3.jpg');
B = rgb2gray(A);
B = imadjust(B,stretchlim(B),[]);

[centers,radii] = imfindcircles(B,[15 120]);

imshow(B);
viscircles(centers,radii,'EdgeColor','b');