function [ signalbuzzy ] = buzzyspeech(x,fs,factor)

%  buzzyspeech --> Creates Buzzy- and Fuzzy-Speech
%
%  <Synopsis>
%    factor that multiplies the buzzy noise (15 = buzzy; 5 = fuzzy)
%
%  <Description>
%    The function takes  a predifined buzzy signal and creates over the 
%    Energy fuzzy or buzzy speech depending on the factor used.    
%
%    INPUT:     x = an audio signal vector
%               fs = corresponding sampling frequency
%               factor = factor that multiplies the buzzy noise 
%               (15 = buzzy; 5 = fuzzy)
%               fo = upper cutoff frequency in [radians]
%
%    Default Example: [ signalbuzzy ] = buzzyspeech(x,fs,5)
%
%  Created by: 
%-----------------------------------------------------------------------

[buzzy,fs] = audioread('noise-wav/buzzynoise.wav');
buzzy = buzzy(1:length(x));

energy = x.*x;
window = 0.05*fs; %(50 ms)
N = floor(length(x)/window);
for i = 1:1:N
    average(i) = mean(energy(i*(window-1)+1:i*(window)));
    if average(i) < 10^-4 % minimum energy of a frame to be considered as speech
        average(i) = 0;
    end
end

buzzy(1:window) = 0;
for i = 2:1:N
    edges = linspace(average(i-1)^0.5, average(i)^0.5, window)';
    buzzy((i-1)*window+1:i*window) = edges.*buzzy((i-1)*window+1:i*window);
end

signalbuzzy = x + factor*buzzy;

