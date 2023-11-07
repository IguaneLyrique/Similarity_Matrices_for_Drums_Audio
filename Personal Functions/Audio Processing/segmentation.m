function [seg, Fe] = segmentation(y, Fs, bpm)
% segmentation.m 
% -------------------------------------------------------------------------
% Segment an audio signal according to a desired 'Tempo' (bpm).
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
%   bpm     : a positive scalar representing the Tempo (bpm)
% 
% Outputs:
%   seg     : a matrix representing the Segmented Audio data
%   Fe      : a positive scalar representing the Sample rate of Segmentation (in Hz)
    
    %% Calculate new information to segment the audio signal
    Fe = fix(60*Fs/bpm);                % Sample rate of Segmentation
    size = fix(length(y)/Fe);           % Number of useful columns

    sec = 1:(Fe);                       % Number of useful lines

    %% Creation of Segmented Audio data
    seg = zeros(fix(Fe),size);
    for k = 1:size
        seg(:,k) = y(sec+Fe*(k-1));
    end
end