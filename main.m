I1 = imread("test/1.jpg");
I2 = imread("test/2.jpg");
I3 = imread("test/3.jpg");
I4 = imread("test/4.jpg");
I5 = imread("test/5.jpg");
I6 = imread("test/6.jpg");
I7 = imread("test/7.jpg");


figure(1)
processDice(I1, 1);
figure(2)
processDice(I2, 1);
figure(3)
processDice(I3, 1);
figure(4)
processDice(I4, 1);
figure(5)
processDice(I5, 1);
figure(6)
processDice(I6, 1);
figure(7)
processDice(I7, 1);
pause;
close all;