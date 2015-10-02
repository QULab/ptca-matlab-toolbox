function [ choppyspeech ] = choppy(signal,fs)

%  choppy --> Clipping at the beginning of the signal
%
%  <Synopsis>
%    [ choppyspeech ] = choppy(signal,fs)
%
%  <Description>
%    Mute some parts of signal only at the beginning of the speech
%
%    INPUT:     signal = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ choppyspeech ] = choppy(signal,fs);
%
%  <See Also>
%    voiunvoi_mod --> Limits of the voiced parts of a signal
%    voiunvoi     --> Voiced/unvoiced segmentation using a sliding window
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

[ segments ] = voiunvoi_mod( signal,25e-3*fs,0.005,0.95 );

% Take the first 5 active segments
xend = segments (3,5) +100;
b = signal(1:xend);

% Mute some parts of the signal until the fifth active segment, the
% unvoiced parts are calculated with sub optimal short-time power threshold
voi1 = (voiunvoi(b,25e-3*fs,0.05,0.85)).*b;
voi2 = signal(xend+1:end);

choppyspeech = [voi1; voi2];

%-----------------------------------------------------------------------
% End of function choppy
%-----------------------------------------------------------------------