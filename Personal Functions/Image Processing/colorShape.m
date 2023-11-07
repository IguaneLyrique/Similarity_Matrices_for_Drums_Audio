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
    clone_image = zeros(length(image));
    size = length(color);

    %% Assign a color to the position of each bounding box
    for k = 1:size
        clone_image(position(1,k):position(2,k), position(1,k):position(2,k)) = color(k);
    end
    
    %% Merge 2 images
    shape = labeloverlay(image,clone_image);
end