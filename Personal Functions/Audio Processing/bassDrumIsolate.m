function [y_filter] = bassDrumIsolate(y, Fs)
% bassDrumIsolate.m
% -------------------------------------------------------------------------
% Isolate the bass drum from the audio signal.
% Display Time study, Frequency study and filtered signal.
% Play only Bass Drum signal.
% -------------------------------------------------------------------------
% Inputs:
%   y       : a matrix representing the Audio data
%   Fs      : a positive scalar representing the Sample rate (in Hz)
% 
% Output:
%   y_filter  : a positive scalar representing desired time (in s)

    figure('Name','Time and frequency study','NumberTitle','off');

    %% Time study
    y = selection(y, 4e-3);
    k = (1 : length(y))';
    t = k/Fs;

    % Display
    subplot(3,1,1)
    plot(t,y);
    zoom on, grid on;
    title("Signal Fond Sonore"),xlabel('Temps (s)'), ylabel('Amplitude(u.a)');

    %% Frequency study
    NFFT = length(y);
    F_fond = Fs.*(0:NFFT-1)./NFFT;
    X_fond = fft(y);
    
    % Display
    subplot(3,1,2)
    plot(F_fond,abs(X_fond));
    zoom on, grid on;
    title("NFFT Fond"),xlabel('Fréquence (Hz)'), ylabel('|FFFT(x)|(u.a)');
    xlim([0, Fs/2])
    
    %% Isolation of Bass Drums
    Fc = 150; % Maximum frequency where there is only bass drum (150 Hz)
    [B, A] = butter(4,2*Fc/Fs,'low');

    y_filter = y;
    for n = 1:10
        y_filter = filter(B, A, y_filter);
    end
    
    sound(y_filter, Fs)
    
    % Display
    subplot(3,1,3)
    plot(t,y_filter);
    zoom on, grid on;
    title("Filtered signal"),xlabel('Time [s]'), ylabel('Amplitude');
end

