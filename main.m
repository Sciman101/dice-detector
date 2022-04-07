I = imread("test/topdown.png");

bounding_boxes = get_bounding_boxes(I,300);
[centers,radii] = pipcounter(I, 10, 50);

% Count pips within each bounding box
dice_values = zeros(size(bounding_boxes,1),1,'uint8');
for j=1 : length(bounding_boxes)-1
    box = bounding_boxes(j,:);
    for p=1 : length(centers)
        point = centers(p,:);
        if (point(1) >= box(1)) && (point(2) >= box(2)) && (point(1) <= box(1)+box(3)) && (point(2) <= box(2)+box(4))
            dice_values(j) = dice_values(j)+1;
        end
    end
end

imshow(I); hold on;
viscircles(centers,radii);
for j = 1 : length(bounding_boxes) - 1
    rectangle('Position', [bounding_boxes(j,1,1), bounding_boxes(j,2,1), ...
        bounding_boxes(j,3,1), bounding_boxes(j,4,1)],'EdgeColor','w','LineWidth',2);
    text(bounding_boxes(j,1,1), bounding_boxes(j,2,1),string(dice_values(j)),'FontSize',32);
end
hold off;