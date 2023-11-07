function [tab] = matchingDegrees(list)
% matchingDegrees.m
% -------------------------------------------------------------------------
% Finds the best degree of similarity between the different parts of the 
% similarity matrix and puts them into a matrix.
% -------------------------------------------------------------------------
% Inputs:
%   list    : a list of cell representing all parts of song's similarity 
%             matrices
% 
% Output:
%   tab     : a matrix representing the maching degrees between each parts 
%             of song's similarity matrices
    
    %% Initialization of variables
    size = length(list);
    tab = zeros(size);

    for i = 1:size
        for j = i+1:size

            %% Finds the smaller item
            if length(list{i}) > length(list{j})
                taille = length(list{j});
                index_min = j;
                index_max = i;
            else
                taille = length(list{i});
                index_min = i;
                index_max = j;
            end
            
            %% Finds the best matching degrees between these items
            diff = abs(length(list{i}) - length(list{j}));
            value_max = 0;
            
            for k = 0:diff
                value = ssim(list{index_min},list{index_max}(1+k:taille+k,1+k:taille+k));
                
                if value_max < value
                    value_max = value;
                end
            end
            tab(i,j) = value_max;
        end
    end
    tab = tab + tab';
end

