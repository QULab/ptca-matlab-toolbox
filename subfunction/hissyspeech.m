function [ hissynoise ] = hissyspeech(x,fs)

%  hissyspeech --> Capture of 's' sounds present in the speech signal
%
%  <Synopsis>
%    [ hissynoise ] = hissyspeech(x,fs)
%
%  <Description>
%    Generation of noise with 's' sounds present in the voiced parts of the 
%    speech signal (all the sounds with more energy between 4 and 11 Khz 
%    than 0 and 4 Khz)
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ hissynoise ] = hissyspeech(x,fs);
%
%  <See Also>
%    voiunvoi --> Voiced/unvoiced segmentation using a sliding window
%
%  Created by: Lucas Almeida
%-----------------------------------------------------------------------

% Voiced parts of the speech signal
[ voiced ] = voiunvoi(x,25e-3*fs,0.005,0.95);

% Duration of windows (10 ms)
window = 0.01*fs;

% Number of windows
N = floor(length(x)/window);

% Indexes of frequencies 4Khz and 11Khz for the windows
s1 = round(4000*window/fs);
s2 = round(11000*window/fs);


% Spectral analysis for each window
aux = [];
for i = 1:1:N
    
    % Only voiced parts
    if voiced(i*window) > 0
        fourier_transform = abs(fft(x((i-1)*window+1:i*window)));
        
        % Compare the ranges: 0-4kHz and 4-11Khz
        spectral_mean = [mean(fourier_transform(1:s1)), mean(fourier_transform(s1:s2))];
        
        % Assortment of windows with predominant 4-11Khz frequencies 
        if spectral_mean(2) > spectral_mean(1)
            aux = [aux,i];
        end
    end
    
end

% First windows of sequences of successive windows
aux_pre = aux(1)-1;
for i = 2:1:length(aux)
    if aux(i)-1 ~= aux(i-1)
        aux_pre = [aux_pre, aux(i)-1];
    end
end

% Last windows of sequences of successive windows
aux_pos = [];
for i = 1:1:length(aux)-1
    if aux(i)+1 ~= aux(i+1)
        aux_pos = [aux_pos,aux(i)+1];
    end
end
aux_pos = [aux_pos,aux(length(aux))+1];
    
% Gain of the windows at the ends of the sequences
hamm = hamming(2*window);
on = hamm(1:window)+1;
off = hamm(window+1:end)+1;

y = x;

% Application of gains
for i = 1:length(aux)
    y((aux(i)-1)*window+1:aux(i)*window) = 2*y((aux(i)-1)*window+1:aux(i)*window);
end
for i = 1:length(aux_pre)
    y((aux_pre(i)-1)*window+1:aux_pre(i)*window) = on.*y((aux_pre(i)-1)*window+1:aux_pre(i)*window);
    y((aux_pos(i)-1)*window+1:aux_pos(i)*window) = off.*y((aux_pos(i)-1)*window+1:aux_pos(i)*window);
end

hissynoise = y-x;

%-----------------------------------------------------------------------
% End of function hissyspeech
%-----------------------------------------------------------------------