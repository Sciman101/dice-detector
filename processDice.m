function [bounding_boxes, dice_values] = processDice(I, v)
    I = imresize(I, [1000 NaN]);
    bounding_boxes = get_bounding_boxes(I,200);
    [centers, radii] = pipcounter(I, 6, 22);
    % Count pips within each bounding box
    dice_values_temp = zeros(size(bounding_boxes,1),1,'uint8');
    for j=1 : size(bounding_boxes, 1)
        box = bounding_boxes(j,:);
        for p=1 : length(centers)
            point = centers(p, :);
            if (point(1) >= box(1)) && (point(2) >= box(2)) && ...
               (point(1) <= box(1) + box(3)) && (point(2) <= box(2) + box(4))
                dice_values_temp(j) = dice_values_temp(j) + 1;
            end 
        end
    end
    i = 1;
   
     dice_values = zeros(1, size(dice_values_temp, 1));

    for j=1: size(bounding_boxes, 1)
        if dice_values_temp(j) >= 1
            dice_values(i) = dice_values_temp(j);
            bounding_boxes(i, :, 1) = bounding_boxes(j, :, 1);
            i = i + 1;
        end
    end
    b = bounding_boxes(bounding_boxes ~= 0);
    bounding_boxes = reshape(b, [], 4);    
    dice_values = dice_values(dice_values >= 1);
    dice_values = dice_values.'; % transpose
    if v == 1
        imshow(I); hold on;
        viscircles(centers,radii);
        for j = 1 : length(dice_values)
            rectangle('Position', [bounding_boxes(j,1,1), ...
                                   bounding_boxes(j,2,1), ...
                                   bounding_boxes(j,3,1), ...
                                   bounding_boxes(j,4,1)], ...
                                   'EdgeColor', 'w', 'LineWidth', 2);
            text(bounding_boxes(j,1,1), bounding_boxes(j,2,1), ...
                string(dice_values(j)),'FontSize',32);
        end
        hold off;
    end

end
