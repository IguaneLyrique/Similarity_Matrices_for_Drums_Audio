function [box] = boundingBox(img_cont, smallest_size)
% boundingBox.m
% -------------------------------------------------------------------------
% Frame each shape on the diagonal with squares.
% -------------------------------------------------------------------------
% Inputs:
%   img_cont        : an binary image representing the Matrix Similarity 
%                     image's edge
%   smallest_size   : a positive scalar representing smallest boxe's size
% 
% Output:
%   box             : a structure representing each shape's bounding box
    
    %% Find all bounding boxes
    box = regionprops(img_cont, 'BoundingBox');
    indexes2delete = [];
    
    %% Identify squares that are not on the diagonal or are too small
    for i = 1:numel(box)
        % Get the coordinates of the center of the square
        x_center = box(i).BoundingBox(1) + 0.5 * box(i).BoundingBox(3);
        y_center = box(i).BoundingBox(2) + 0.5 * box(i).BoundingBox(4);
    
        % Check conditions (diagonal and size)
        if ~(x_center == y_center && (box(i).BoundingBox(3) >= smallest_size || box(i).BoundingBox(4) >= smallest_size))
            indexes2delete = [indexes2delete, i];
        end
    end
    
    %% Identify landlocked squares 
    for i = 1:numel(box)
        for j = 1:numel(box)
            if i ~= j
                if is_inside(box(i).BoundingBox, box(j).BoundingBox)
                    indexes2delete = [indexes2delete, i];
                    break;
                end
            end
        end
    end
    
    %% Remove all squares that do not meet requirements
    box(indexes2delete) = [];
end

