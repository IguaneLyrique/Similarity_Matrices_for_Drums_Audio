function [] = segments100Display(seg, t_seg, index)
% segments100Display.m 
% -------------------------------------------------------------------------
% Display 100 segmented of the audio signal and delete the silent part at
% the beginning and ending.
% -------------------------------------------------------------------------
% Inputs:
%   seg     : a matrix representing the Segmented Audio data
%   t_seg   : a vector representing the time of one's Segmented Audio data
%   index   : a positive scalar representing the first index of Segmented
%             Audio data

    figure('Name','Similarity Matrice','NumberTitle','off');
    for i = 1:100
        subplot(10,10,i);
        plot(t_seg, seg(:,i+index));
    end
end