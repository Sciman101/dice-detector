function [centers,radii] = pipcounter(image,minRadius,maxRadius)

    %A = imread('test/3.jpg');
    B = rgb2gray(image);
    B = imadjust(B,stretchlim(B),[]);
    
    [c1,r1] = imfindcircles(B,[minRadius maxRadius],'ObjectPolarity','Bright');
    [c2,r2] = imfindcircles(B,[minRadius maxRadius],'ObjectPolarity','Dark');
    
    % Combine dark/light searches
    centers = cat(1,c1,c2);
    radii = cat(1,r1,r2);
    numCircles = uint8(size(radii,1));
    
    % Generate mask for overlapping elements
    mask = zeros(numCircles,'logical');
    % Find all circles that overlap within a tolerance
    for i=1:numCircles
      for j=i:numCircles
          
          if j ~= i 
            p1 = centers(i,:);
            p2 = centers(j,:);
            d = (p1(1)-p2(1))^2 + (p1(2)-p2(2))^2;
            r = (radii(i)+radii(j));
            if d <= r*r || (abs(p2(2)-p1(2)) < r && d <= r*r*2)
              mask(i) = 1;
              break
            end
          end
        
      end
    end
    centers(mask,:) = [];
    radii(mask) = [];
    
    %imshow(B);
    %viscircles(centers,radii,'EdgeColor','b');
end