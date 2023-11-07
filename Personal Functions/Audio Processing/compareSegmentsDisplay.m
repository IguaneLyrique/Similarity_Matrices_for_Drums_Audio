function [] = compareSegmentsDisplay(y, t, seg, t_seg, nb, Fs)
% compareSegmentsDisplay.m 
% -------------------------------------------------------------------------
% Display to compare main signal and segmented signals. 
% This function is just a visual check that the segmentation function is 
% working properly.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   t       : a vector representing the time of Audio data
%   seg     : a matrix representing the Segmented Audio data
%   t_seg   : a vector representing the time of one's Segmented Audio data
%   nb      : a positive scalar representing the number of desired plots

    figure('Name','Comparision between Signal and Segments','NumberTitle','off');
    lim = length(t_seg)/Fs;
    for i = 1:fix(nb)
        subplot(nb,2,2*i-1);
        plot(t,y);
        xlim([5+(i-1)*lim,5+(i)*lim]);
    
        subplot(nb,2,2*i);
        plot(t_seg, seg(:,5+i));
    end
end