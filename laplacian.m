I=imread("test/1.jpg");
I=rgb2gray(I);
I=double(I);

Laplacian = [0 1 0;1 -4 1;0 1 0];

I2 = conv2(I,Laplacian,'same');

imtool(I,[]);
imtool(abs(I2),[]);