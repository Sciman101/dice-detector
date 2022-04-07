function bounding_boxes = get_bounding_boxes(I, area_threshhold)
  bbpad = 10;
  mergestructs = @(x,y) cell2struct([struct2cell(x);struct2cell(y)],[fieldnames(x);fieldnames(y)]);
  I = rgb2gray(I);
  edges = edge(I, 'Canny', .1);
  areas_cords = mergestructs(regionprops(edges, 'BoundingBox'), regionprops(edges, 'Area'));
  bounding_boxes = zeros(1, 4, length(areas_cords));
  j = 1;
  for k = 1 : length(areas_cords)
   if areas_cords(k).Area > area_threshhold
    BB = areas_cords(k).BoundingBox;
    BB(1) = BB(1) - bbpad;BB(2) = BB(2) - bbpad;
    BB(3) = BB(3) + bbpad*2;BB(4) = BB(4) + bbpad*2;
    bounding_boxes(j, :, 1) = BB;
    j = j + 1;
   end
  end
  % trim array
  b = bounding_boxes(bounding_boxes > 0);
  bounding_boxes = reshape(b, [], 4);
end
