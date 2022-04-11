function [bounding_boxes, dice_values] = processDice(I, v)
    
    bounding_boxes_temp = get_bounding_boxes(I,200);
    [centers_temp, radii_temp] = pipcounter(I, 6, 22);
    % Count pips within each bounding box
    dice_values_temp = zeros(size(bounding_boxes_temp,1),1,'uint8');
    for j=1 : size(bounding_boxes_temp, 1)
        box = bounding_boxes_temp(j,:);
        for p=1 : length(centers_temp) -1
            point = centers_temp(p, :);
            if (point(1) >= box(1)) && (point(2) >= box(2)) && ...
               (point(1) <= box(1) + box(3)) && (point(2) <= box(2) + box(4))

                dice_values_temp(j) = dice_values_temp(j) + 1;
            end 
        end
    end
    i = 1;
    bounding_boxes = zeros(1,4, size(dice_values_temp, 1));
   
    dice_values = zeros(1, size(dice_values_temp, 1));
    dice_values = dice_values.'; % transpose
    centers = zeros(size(centers_temp, 1), 2); 
    radii =  zeros(1, size(radii_temp, 1), 1);

    for j=1: size(bounding_boxes_temp, 1)
        if dice_values_temp(j) >= 1
            dice_values(i) = dice_values_temp(j);
            bounding_boxes(i, :, 1) = bounding_boxes_temp(j, :, 1);
            i = i + 1;
        end
    end

    tol = 30;
    i = 1;
    for j=1: size(centers_temp, 1)
        for k = 1: size(centers_temp, 1)
            
            point = centers_temp(j, :);
            point2 = centers_temp(k, :);
            if point == point2 
                continue 
            end
            if  ~((abs(point(1) - point2(1)) > tol) || ...
                 (abs(point(2) - point2(2)) > tol))
                centers(i, :) = centers_temp(j, :);
                radii(i) = radii_temp(j);
                i = i + 1;
            end
                
            
        end
    end
    b = bounding_boxes(bounding_boxes > 0);
    bounding_boxes = reshape(b, [], 4);    
    dice_values = dice_values(dice_values >=1);


    if v == 1
        imshow(I); hold on;
        viscircles(centers,radii);
        for j = 1 : size(dice_values, 1)
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