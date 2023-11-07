function [r] = onsetDetectionWithPeaks(y, Fs, nb_sec)
% onsetDetectionWithPeaks.m
% -------------------------------------------------------------------------
% Smooth the signal to find peaks and tempo and Display the all plot's 
% transformation between the Waveform and the Half-wave rectification of 
% the Audio signal with viewable peaks.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
%   nb_sec  : a positive scalar representing desired time (in s)
    
    figure('Name','Onset Detection','NumberTitle','off');
    %% Waveform
    new_y = selectionTime(y, Fs, 4e-3, nb_sec);
    k = (0 : length(new_y)-1);
    t = k./Fs;
    [N, ~] = size(new_y);
    
    subplot(4,1,1)
    plot(t, new_y);
    title("Waveform");
    
    %% Local Energy Function
    M = 5000;
    w = blackman(2*M+1, 'periodic');
    E = zeros(N, 1);
    
    for n = 1:N
        sum = 0;
        for m = -M:M
            if (n+m>0) && (n+m<N)
                sum = sum + abs(new_y(n+m)*w(m+M+1))^2;
            end
        end
        E(n) = sum;
    end
    
    subplot(4,1,2)
    plot(t, E);
    title("Local Energy Function");
    
    %% Discrete derivative
    dd = zeros(N, 1);
    for n = 1:N-1
        dd(n) = (E(n+1)-E(n))/2;
    end
    dd(N) = dd(N-1);
    
    subplot(4,1,3)
    plot(t, dd);
    title("Discrete Derivative");
    
    %% Half-wave rectification
    r = zeros(N, 1);
    for n = 1:N
        r(n) = (dd(n)+abs(dd(n)))/2;
    end
    
    [pic_valeurs, pic_positions] = findpeaks(r,'MinPeakHeight', 0.05*max(r));
    
    subplot(4,1,4)
    plot(t, r, pic_positions./Fs, pic_valeurs, 'rv')
    title("Half-wave rectification");
end