function [dist] = graphTheory(tab, max_threshold, min_threshold)
% graphTheory.m
% -------------------------------------------------------------------------
% Constructs the distance table of graph theory based on the best.
% -------------------------------------------------------------------------
% Inputs:
%   tab            : a cell's list representing all parts of song's 
%                    similarity matrices
%   max_threshold  : a positive scalar representing threshold of similarity
%   min_threshold  : a positive scalar representing threshold of similarity
% 
% Output:
%   dist           : a matrix representing the length of the shortest path 
%                 between node i and node j
    
    %% Initialization of variables
    size = length(tab);
    compteur = 1;

    for i = 1:size
        verif = false;
        for j = 1:size
            %% Takes all points with a score above the required threshold
            if tab(i,j) > max_threshold
                vect1(compteur) = i;
                vect2(compteur) = j;
                compteur = compteur + 1;
                verif = true;
            end
        end

        %% Takes the best point if none of them are above the required threshold
        if verif == false
            v_max = 0;
            indice_v = 0;
            %% Tests all points to find the best value
            for j = 1:size
                if v_max < tab(i,j)
                    v_max = tab(i,j);
                    indice_v = j;
                end
            end
            if v_max > min_threshold
                vect1(compteur) = i;
                vect2(compteur) = indice_v;
                compteur = compteur + 1;
            end
        end
    end
   
    %% Constructs graph Theory and distance matrix
    G = digraph(vect1, vect2);
    dist = distances(G);
end

