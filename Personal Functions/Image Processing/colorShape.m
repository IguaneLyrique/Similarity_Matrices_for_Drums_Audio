function [shape] = colorShape(image, color, position)
% colorShape.m
% -------------------------------------------------------------------------
% Color the similarity matrix based on a color index vector.
% -------------------------------------------------------------------------
% Inputs:
%   image       : an image representing the Matrix Similarity
%   color       : a vector representing color index
%   position    : a vector representing position of each bounding box
% 
% Output:
%   shape       : a structure representing the Matrix Similarity with 
%                 colored chorus (bounding box)

    %% Initialization of variables
    customColorMap = [
        1 0 0;          % Red
        0 0 1;          % Blue
        0 1 0;          % Green
        1 0.65 0;       % Orange
        1 0.75 0.8;     % Pink
        1 1 0;          % Yellow
        0.5 0 0.5;      % Purple
        0.64 0.16 0.16  % Brown
    ];
    clone_image = zeros(length(image));
    size = length(color);

    %% Assign a color to the position of each bounding box
    for k = 1:size
        clone_image(position(1,k):position(2,k), position(1,k):position(2,k)) = color(k);
    end
    
    %% Merge 2 images
    shape = labeloverlay(image,clone_image,'Colormap',customColorMap);
end
