function [matSimi] = correlationHandNormalize(seg)
% correlationHandNormalize.m 
% -------------------------------------------------------------------------
% Construct an audio similarity matrix.
% This correlation function use the : xcorr function. 
% To obtain results between 0 and 1, divide the result by the diagonal
% one.
% -------------------------------------------------------------------------
% Input:
%   seg       : a matrix representing the Segmented Audio data
% 
% Output:
%   matSimi   : a matrix representing the Audio Similarity matrix

    %% Calculate new information to segment the audio signal
    [~,numCols] = size(seg);    
    matSimi = zeros(numCols,numCols);

    %% Calculate the maximum correlation of segmented signals between 0 and 1
    for j = 1:numCols
        for i = 1:numCols
            % Calculates the maximum correlation of segmented signals
            val = max(xcorr(seg(:,i), seg(:,j)));

            % Calculates the maximum correlation of diagonal segmented signals
            if i<j
                diagonal = max(xcorr(seg(:,i), seg(:,i)));
            else
                diagonal = max(xcorr(seg(:,j), seg(:,j)));
            end

            % Normalized
            matSimi(numCols-i+1, j) = val/diagonal;
        end
    end
end