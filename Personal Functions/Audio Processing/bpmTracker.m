function [bpm] = bpmTracker(y, Fs, nb_sec, scale)
% bpmTracker.m
% -------------------------------------------------------------------------
% Find the signal's 'Tempo' (bpm).
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
%   nb_sec  : a positive scalar representing desired time (in s)
%   scale   : a positive scalar representing the cut off Threshold
% 
% Output:
%   bpm     : a positive scalar representing the signal's 'Tempo' (bpm)
    
    %% Smoothing the signal
    new_y = onsetDetection(y, Fs, nb_sec);
    
    %% Reducing the number of Smooth signal's points
    [new_y2, ~] = scaleChange(new_y, Fs, scale);

    %% Calculate the best Periodes with Correlation
    [per,pow,~] = bestcorrelation(new_y2);
    
    %% Calculate the bpm with the best Periode
    [~,i] = max(pow);
    Te = (per(i)*scale)./Fs;
    bpm = 60/Te;
    disp("Tempo of this audio signal is "+bpm+"BPM");
end