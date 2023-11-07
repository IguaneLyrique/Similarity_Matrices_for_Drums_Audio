function [shape] = showColor(image, img_cont, smallest_size, max_threshold, min_threshold)
% showColor.m
% -------------------------------------------------------------------------
% Builds bounding boxes and assigns a color to similar bounding boxes for 
% display.
% -------------------------------------------------------------------------
% Inputs:
%   image          : an image representing the Matrix Similarity
%   img_cont       : an binary image representing the Matrix Similarity 
%                     image's edge
%   smallest_size  : a positive scalar representing smallest boxe's size
%   max_threshold  : a positive scalar representing threshold of similarity
%   min_threshold  : a positive scalar representing threshold of similarity
% 
% Output:
%   shape          : a structure representing the Matrix Similarity with 
%                    colored chorus (bounding box)

    %% Creating bounding boxes
    img_cont = doubleVertexDetection(img_cont);
    box = boundingBox(img_cont, smallest_size);
    
    %% Extraction of bounding boxes
    [squares, position] = squaresList(image, box, smallest_size);
    
     %% Calculating degrees of correspondence
    tab = matchingDegrees(squares);
    
    %% Group similar images with Graph Theory
    d = graphTheory(tab, max_threshold, min_threshold);
    
    %% Gives the same color to similar images
    color = similarityColor(d);
    
    %% Color the similarity matrix
    shape = colorShape(image, color, position);
end