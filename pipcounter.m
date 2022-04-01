A = imread('test/2.jpg');
B = rgb2gray(A);
B = imadjust(B,stretchlim(B),[]);

MIN_RADIUS = 10;
MAX_RADIUS = 30;

[c1,r1] = imfindcircles(B,[MIN_RADIUS MAX_RADIUS],'ObjectPolarity','Bright');
[c2,r2] = imfindcircles(B,[MIN_RADIUS MAX_RADIUS],'ObjectPolarity','Dark');

% Combine dark/light searches
centers = cat(1,c1,c2);
radii = cat(1,r1,r2);
numCircles = uint8(size(radii,1));

% Mask out outliers in terms of radius
outmask = isoutlier(radii);
centers(outmask,:) = [];
radii(outmask) = [];

% Generate mask for overlapping elements
mask = zeros(numCircles,'logical');
% Find all circles that overlap within a tolerance
for i=1:numCircles
  for j=i:numCircles
      
      if j ~= i 
        p1 = centers(i,:);
        p2 = centers(j,:);
        d = (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2;
        r = (radii(i)+radii(j)) * 0.75;
        if d <= r*r
          mask(i) = 1;
          break
        endif
      endif
    
  endfor
endfor
centers(mask,:) = [];
radii(mask) = [];

imshow(B);
viscircles(centers,radii,'EdgeColor','b');