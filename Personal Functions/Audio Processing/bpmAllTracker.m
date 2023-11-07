function [bpm] = bpmAllTracker(y, Fs, nb_sec, scale)
% bpmAllTracker.m
% -------------------------------------------------------------------------
% Find the all 'Tempos' (bpm) of the audio signal.
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
    new_y = onsetDetectionWithPeaks(y, Fs, nb_sec);
    
    %% Reducing the number of Smooth signal's points
    [new_y2, ~] = scaleChange(new_y, Fs, scale);

    %% Calculate the best Periodes with Correlation
    [per,pow,~] = bestcorrelation(new_y2);
    
    %% Calculate the bpm with the best Periodes
    for i = 1:length(per)
        if per(i)~=1
            Te = (per(i)*scale)./Fs;
            bpm = 60/Te;
            disp("There is a repeat every "+per(i)+" values. This gives a bpm of : "+bpm+"|| With pow :"+pow(i));
        end
    end
end