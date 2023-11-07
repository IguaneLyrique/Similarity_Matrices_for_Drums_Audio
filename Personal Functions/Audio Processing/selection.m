function [new_y] = selection(y, cutoff)
% selection.m
% -------------------------------------------------------------------------
% Select an audio signal and delete the silent part at the
% beginning and ending.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   cutoff  : a positive scalar representing the cut off Threshold
% 
% Output:
%   new_y   : a matrix representing the new Audio data without silent part

    %% Assembly of the 2 signal parts if in stereo
    [numLins,numCols] = size(y);

    if numCols==2
        y = y(:,1) + y(:,2);
    end

    %% Suppression of the silent part at the beginning of the signal
    beginning = 1;      % beginning is the element position who is no longer silent (beginning)
    ending = numLins;   % ending is the element position who is no longer silent (ending)

    while abs(y(beginning,1))<=cutoff
        beginning = beginning+1;
    end

    while abs(y(ending,1))<=cutoff
        ending = ending-1;
    end

    new_y = y(beginning:ending);
end