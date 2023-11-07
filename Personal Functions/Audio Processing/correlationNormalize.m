function [matSimi] = correlationNormalize(seg)
% correlationNormalize.m
% -------------------------------------------------------------------------
% Construct an audio similarity matrix.
% This correlation function use the : xcorr function with the 'normalized'
% option.
% Results are directly between 0 and 1.
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
        for i = 1:numCols
            matSimi(i,j) = max(xcorr(seg(:,i), seg(:,j),'normalized'));
        end
    end
end