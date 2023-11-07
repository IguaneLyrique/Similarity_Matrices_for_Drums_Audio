function [matSimi] = correlationHalfNormalize(seg)
% correlationHalfNormalize.m
% -------------------------------------------------------------------------
% Construct an audio similarity matrix.
% This correlation function use the : xcorr function with the 'normalized'
% option. Results are directly between 0 and 1.
%
% To save time and calculation, we only calculate the part above the 
% diagonal (without the diagonal, as it is equal to 1).
% We add our matrix with its transposer and a diagonal matrix.
% -------------------------------------------------------------------------
% Input:
%   seg       : a matrix representing the Segmented Audio data
% 
% Output:
%   matSimi   : a matrix representing the audio similarity matrix

    %% Calculate new information to segment the audio signal
    [~,numCols] = size(seg);    
    matSimi = zeros(numCols,numCols);

    %% Calculate the maximum correlation of segmented signals
    for j = 1:numCols
        for i = j+1:numCols
            matSimi(i,j) = max(xcorr(seg(:,i), seg(:,j),'normalized'));
        end
    end
    [~,numCols] = size(seg);
    matSimi = matSimi + matSimi' + eye(numCols);
end