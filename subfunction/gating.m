function [ noisegating ] = gating(x,fs,n)

%  gating --> Generation of noise gating
%
%  <Synopsis>
%    [ noisegating ] = gating(x,fs,3)
%
%  <Description>
%    Find the voiced (sentences) and unvoiced parts of the signal and
%    modulate the white noise proportionally to it (voiced = n x unvoiced)
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               n = how many times the voiced parts is louder than the
%               unvoiced parts
%
%    Default Example: [ noisegating ] = gating(x,fs,3);
%               The voiced parts have the amplitude 3 times greater than
%               the unvoiced parts
%
%  <See Also>
%    voiunvoi_mod --> Limits of the voiced parts of a signal
%
%  Created by: Friedemann Köster and Lucas Almeida
%-----------------------------------------------------------------------

% Limits of the voiced parts of the signal
[ segments ] = voiunvoi_mod(x,25e-3*fs,0.005,0.95);

% Find the very beginninging of the sentences
% Beginning of first sentence
beginning = segments(2,1);
last = [];

% Others sentences (voiced parts with a preceding unvoiced part greater
% than 0,4s)
for i = 2:length(segments)
    if segments(2,i) - segments(3,i-1) > 0.4*fs
        beginning = [beginning,segments(2,i)];
        last = [segments(3,i-1),last];
    end
end

% End of final sentence
last = [last,segments(3,end)];

% White noise
[ white,fs ] = audioread('noise-wav/whitenoise.wav');
white = white(1:length(x));

% Make the voiced parts 3 times greater than unvoiced parts
for i = 1:1:length(beginning)
    white(beginning(i):last(i)) = n*white(beginning(i):last(i));
end

noisegating = (1/n)*white;

%-----------------------------------------------------------------------
% End of function gating
%-----------------------------------------------------------------------