function [] = correlationDisplay(matSimi, t, name)
% correlationDisplay.m
% -------------------------------------------------------------------------
% Display the Similarity Matrice with time scale, label and title.
% -------------------------------------------------------------------------
% Inputs:
%   matSimi : a matrix representing the audio similarity matrix
%   t       : a vector representing the time of Audio data (in s)
%   name    : a name representing the filename of the song      
    
    figure('Name','Similarity Matrice','NumberTitle','off');
    imagesc('XData',t,'YData',t,'CData',matSimi);
    ylim('tight');
    xlim('tight');
    xlabel('Time [in s]');
    ylabel('Time [in s]');
    title(name);
end