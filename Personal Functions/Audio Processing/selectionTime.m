function [new_y] = selectionTime(y, Fs, cutoff, nb_sec)
% selectionTime.m 
% -------------------------------------------------------------------------
% Select an audio signal, delete the silent part at the 
% beginning and isolate desired selection time.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
%   cutoff  : a positive scalar representing the cut off Threshold
%   nb_sec  : a positive scalar representing desired time (in s)
% 
% Output:
%   new_y   : a matrix representing the new Audio data without silent part

    %% Assembly of the 2 signal parts if in stereo
    [~,numCols] = size(y);

    if numCols==2
        y = y(:,1) + y(:,2);
    end

    %% Suppression of the silent part at the beginning of the signal
    n = 1;  % n is the element position who is no longer silent

    while abs(y(n,1))<=cutoff
        n = n+1;
    end
    
    %% Isolation of desired selection time
    new_y = y(n:nb_sec*Fs+n-1);
end