function [ correlatednoise ] = correlatedspeech(x,fs,noise)

%  correlatedspeech --> Generation of a noise correlated with the speech
%
%  <Synopsis>
%    [ correlatednoise ] = correlatedspeech(x,fs,noise)
%
%  <Description>
%    Generation of a correlated signal through modulation of noise 
%    proportionally to the square root of the energy of the voiced
%    parts of the signal
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               noise = signal wich will be correlated with the speech
%
%    Default Example: [ correlatednoise ] = correlatedspeech(x,fs,noise);
%
%  <See Also>
%    voiunvoi --> Voiced/unvoiced segmentation using a sliding window
%
%  Created by: Lucas Almeida / Falk Schiffner
%-----------------------------------------------------------------------

noise = noise(1:length(x));

% Energy of the voiced parts
[ voiced ] = voiunvoi(x,25e-3*fs,0.005,0.95);
energy = voiced.*x.*x;

% Duration of windows (50 ms)
window = 0.05*fs;

% Number of windows
N = floor(length(x)/window);

% Average energy per window
for i = 1:1:N
    average(i) = mean(energy(i*(window-1)+1:i*(window)));
end

% Generation of the correlated noise without abrupt changes
noise(1:window) = 0;
for i = 2:1:N
    edges = linspace(average(i-1)^0.5, average(i)^0.5, window)';
    noise((i-1)*window+1:i*window) = edges.*noise((i-1)*window+1:i*window);
end

correlatednoise = noise;

%-----------------------------------------------------------------------
% End of function correlatedspeech
%-----------------------------------------------------------------------