function bounding_boxes = get_bounding_boxes(I, min_thresh, max_thresh)
  bbpad = -15;
  I = rgb2gray(I);
  edges = edge(I, 'Canny', .1);
  regions = regionprops(edges, 'BoundingBox');  
  bounding_boxes = zeros(1, 4, length(regions));
  j = 1;
  for k = 1 : length(regions)
   BB = regions(k).BoundingBox;
   if (BB(3) > min_thresh && BB(3) < max_thresh) && ...
      (BB(4) > min_thresh && BB(4) < max_thresh) % min/max thresh
    dif = abs(BB(3) - BB(4));   
    if dif < 50 % testing for square like shapes
        BB(1) = BB(1) - bbpad;BB(2) = BB(2) - bbpad;
        BB(3) = BB(3) + bbpad*2;BB(4) = BB(4) + bbpad*2;
        bounding_boxes(j, :, 1) = BB;
        j = j + 1;
    end
   end
  end
  % trim array
  b = bounding_boxes(bounding_boxes ~= 0);
  bounding_boxes = reshape(b, [], 4);
end
