function [ signalfluctuation ] = fluctuation(x,fs,window,min_gain)

%  noisefluc --> Generation of a signal with level fluctuations
%
%  <Synopsis>
%    [ signalfluctuation ] = fluctuation(x,fs,window,min_gain)
%
%  <Description>
%    Separates the signal (x) into parts of equal duration (window) and
%    applies a random gain between min_gain and 1+min_gain to each part
%
%    INPUT:     x = a signal vector
%               fs = corresponding sampling frequency
%               window = time in [s] the signal remains in a constant level
%               min_gain = minimum random gain applied to each window
%
%    Default Example: [ signalfluctuation ] = fluctuation(x,fs,0.2,0);
%               The level fluctuation occurs every 0,2s and the gain
%               applied to each window is between 0 and 1
%
%  Created by: Falk Schiffner / Lucas Almeida
%-----------------------------------------------------------------------

% Lenght of each window
frame = round(window*fs);

% Number of windows
aux = floor(length(x)/frame);

% Applying the random gain
for i = 1:aux
    fluc((i-1)*frame+1:i*frame,1) = (rand+min_gain)*x((i-1)*frame+1:i*frame);
end

signalfluctuation = fluc;

%-----------------------------------------------------------------------
% End of function fluctuation
%-----------------------------------------------------------------------