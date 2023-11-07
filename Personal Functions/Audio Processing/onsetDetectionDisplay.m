function [] = onsetDetectionDisplay(y, Fs, time)
% onsetDetectionDisplay.m
% -------------------------------------------------------------------------
% Display the all plot's transformation between the Waveform and the 
% Logarithmic Novelty Function of the Audio signal.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
%   nb_sec  : a positive scalar representing desired time (in s)
    
    figure('Name','Onset Detection','NumberTitle','off');
    %% Waveform
    new_y = selectionTime(y, Fs, 4e-3, time);
    k = (0 : length(new_y)-1);
    t = k./Fs;
    [N, ~] = size(new_y);
    
    subplot(6,1,1)
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
    
    subplot(6,1,2)
    plot(t, E);
    title("Local Energy Function");
    
    %% Discrete derivative
    dd = zeros(N, 1);
    for n = 1:N-1
        dd(n) = (E(n+1)-E(n))/2;
    end
    dd(N) = dd(N-1);
    
    subplot(6,1,3)
    plot(t, dd);
    title("Discrete Derivative");
    
    %% Half-wave rectification
    r = zeros(N, 1);
    for n = 1:N
        r(n) = (dd(n)+abs(dd(n)))/2;
    end
    
    subplot(6,1,4)
    plot(t, r);
    title("Half-Wave Rectification");
    
    %% Novelty Function
    DeltaE = zeros(N, 1);
    for n = 1:N-1
        if r(n+1)>=r(n)
            DeltaE(n) = r(n+1)-r(n);
        else
            DeltaE(n) = 0;
        end
    end
    DeltaE(N) = 0;
    
    subplot(6,1,5)
    plot(t, DeltaE);
    title("Novelty Function");
    
    %% Logarithmic Novelty Function
    DeltaLogE = zeros(N,1);
    for n = 1:N-1
        if DeltaE(n+1) == 0 || DeltaE(n) == 0 || log10(DeltaE(n+1)/DeltaE(n))<0
            DeltaLogE(n) = 0;
        else
            DeltaLogE(n) = log10(DeltaE(n+1)/DeltaE(n));
        end
    end
    DeltaLogE(N) = 0;
    
    subplot(6,1,6)
    plot(t, DeltaLogE);
    title("Logarithmic Novelty Function");
end