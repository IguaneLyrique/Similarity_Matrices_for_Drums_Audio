function [color] = similarityColor(dist)
% similarityColor.m
% -------------------------------------------------------------------------
% Creates a color matrix based on the distance diagram. 
% This makes it possible to give the same color to the same part.
% -------------------------------------------------------------------------
% Inputs:
%   dist    : a matrix representing the length of the shortest path between
%             node i and node j
% 
% Output:
%   color   : a vector representing the color index

    %% Initialization of variables
    size = length(dist);
    color = zeros(1,size);
    color_index = 1;
    
    %% Color assignment
    for i = 1:size
        if color(i) == 0
            color(i) = color_index;
            color_index = color_index+1;
        end
        for j = i+1:size
            if color(j) == 0
                %% Browses the distance matrix
                if dist(i,j) ~= Inf || dist(j,i) ~= Inf
                    color(j) = color(i);
                end
            end
        end
    end
end

