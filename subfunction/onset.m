function [ preecho ] = onset(x,fs,T,duration)

%  preecho --> Generation of pre-echo
%
%  <Synopsis>
%    [ preecho ] = onset(x,fs,T,duration)
%
%  <Description>
%    Pink noise is generated at the very beginning of the speech signal (x)
%    for every voiced part which follow an unvoiced part with duration
%    greater than 0,4 second. The noise has a certain duration starting 0,1
%    second before the sentences and fades out
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               T = duration of noise in [s]
%               duration = value in [s] of the pre echo
%
%    Default Example: [ preecho ] = onset(x,fs,T,0.3);
%               Each pre-echo noise generated fades out within 0,3 second
%
%  <See Also>
%    voiunvoi_mod --> Limits of the voiced parts of a signal
%    fadeout --> Fading out of a speech file
%
%  Created by: Lucas Almeida
%-----------------------------------------------------------------------

% Limits of the voiced parts of the signal
[ segments ] = voiunvoi_mod( x,25e-3*fs,0.005,0.95 );

% Find the very begining of the sentences
% First sentence
begin = segments(2,1);

% Others sentences (voiced parts with a preceding unvoiced part greater
% than 0,4s)
for i = 2:length(segments)
    if segments(2,i) - segments(3,i-1) > 0.4*fs
        begin = [begin,segments(2,i)];
    end
end

% Pre-echo starts 0,1s before the sentences
begin = begin - 0.1*fs;

% Pink noise
[ pink ] = pinknoise(fs,T);
pink = pink(1:length(x));

% Fadeout function parameters
Tout= duration; 
Tbegin = begin/fs;
Tend = 0;
noise = zeros(length(pink),1);

% Generation of pre-echo for each sentence
for i = 1:1:length(Tbegin)
    
    % Only positive time
    if Tbegin(i) <= 0
        Tbegin(i) = 10^-3;
    end
    
    % Fading out of pink noise
    [ noiseout ] = fadeout(pink,fs,Tend,Tbegin(i),Tout);
    index_begin = round(Tbegin(i)*fs);
    noiseout(1:index_begin) = 0;
    noise = noise + noiseout;
    
end

preecho = noise;

%-----------------------------------------------------------------------
% End of function onset
%-----------------------------------------------------------------------