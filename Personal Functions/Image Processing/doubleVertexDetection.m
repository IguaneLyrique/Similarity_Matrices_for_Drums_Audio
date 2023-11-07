function [img_cont] = doubleVertexDetection(img_cont)
% doubleVertexDetection.m
% -------------------------------------------------------------------------
% Distinguishes double vertices on the diagonal of a binary image.
% -------------------------------------------------------------------------
% Inputs:
%   img_cont    : an binary image representing the Matrix Similarity 
%                     image's edge
% 
% Output:
%   img_cont    : an binary image representing the Matrix Similarity 
%                     image's edge

    for i = 1:length(img_cont)-1
        if img_cont(i,i) == 1 && img_cont(i+1,i+1) == 1
            img_cont(i,i) = 0;
        end
    end
end

