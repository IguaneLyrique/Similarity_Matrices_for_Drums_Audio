function [DeltaE] = onsetDetection2(y)
% onsetDetection2.m
% -------------------------------------------------------------------------
% Smooth the signal to find peaks and tempo.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
% 
% Output:
%   DeltaE  : a vector representing Novelty Function (smoothed signal)
    
    %% Waveform
    new_y = selection(y, 4e-3);
    [N, ~] = size(new_y);
    
    %% Local Energy Function
    M = 3000;
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

    %% Discrete derivative
    dd = zeros(N, 1);
    for n = 1:N-1
        dd(n) = (E(n+1)-E(n))/2;
    end
    dd(N) = dd(N-1);
    
    %% Half-wave rectification
    r = zeros(N, 1);
    for n = 1:N
        r(n) = (dd(n)+abs(dd(n)))/2;
    end
    
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
end