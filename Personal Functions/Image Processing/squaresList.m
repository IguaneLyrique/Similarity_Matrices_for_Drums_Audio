function [squares, position] = squaresList(img, box, smallest_size)

    %% Initialization of various variables
    size = length(img);
    counter = 1;
    nb_squares = length(box);
    
    %% Extract bounding boxes
    for k = 1:nb_squares
        % Position of bounding box
        x = uint16(box(k).BoundingBox(1));
        y = x+uint16(box(k).BoundingBox(3))-1;

        % Extraction
        squares(counter) = {img(x:y, x:y)};

        % Save bounding box position
        position(1,counter) = x;
        position(2,counter) = y;
        counter = counter + 1;
    end
    
    %% If available, extract the part before the first box
    if uint16(box(1).BoundingBox(1)-1) > smallest_size
        % Position of bounding box
        x = 1;
        y = uint16(box(1).BoundingBox(1)-1);

        % Extraction
        squares(counter) = {img(x:y, x:y)};

        % Save bounding box position
        position(1,counter) = x;
        position(2,counter) = y;
        counter = counter + 1;
    end
    
    %% If available, extract the part after the last box
    if uint16(box(end).BoundingBox(1) + box(end).BoundingBox(3) +1) < size-smallest_size
        % Position of bounding box
        x = uint16(box(end).BoundingBox(1) + box(end).BoundingBox(3) +1);
        y = size;

        % Extraction
        squares(counter) = {img(x:y, x:y)};

        % Save bounding box position
        position(1,counter) = x;
        position(2,counter) = y;
        counter = counter + 1;
    end

    %% Extract the part between each box
    for i = 1:nb_squares-1
        % Position of bounding box
        x = uint16(box(i).BoundingBox(1) + box(i).BoundingBox(3));
        y = uint16(box(i+1).BoundingBox(1)-1);

        if y-x > smallest_size
            % Extraction
            squares(counter) = {img(x:y, x:y)};
    
            % Save bounding box position
            position(1,counter) = x;
            position(2,counter) = y;
            counter = counter + 1;
        end
    end
end

