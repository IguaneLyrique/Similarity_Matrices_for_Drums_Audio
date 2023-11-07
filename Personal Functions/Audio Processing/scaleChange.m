function [new_y, new_t] = scaleChange(y, Fs, scale)
% scaleChange.m
% -------------------------------------------------------------------------
% Find the signal's 'Tempo' (bpm).
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
%   scale   : a positive scalar representing the cut off Threshold
% 
% Outputs:
%   new_y   : a vector representing the signal with the new desired scale
%   new_t   : a vector representing the time of reduced signal with the
%             new desired scale

    %% Initialization of vector size
    size = length(y);
    new_size = fix(length(y)/scale);
    
    %% Creation of signal with less points
    new_y = zeros(1, new_size);
    new_t = (1 : new_size)'./Fs*scale;
    
    %% Filling of new vector
    indice = 0;
    for k = 1:size
        if rem(k,scale)==0
            indice = indice +1;
            new_y(indice) = y(k);
        end
    end
end

