function [ signalselfclipping ] = selfclipping(signal,fs)

%  selfclipping --> Self clipping on a speech file array
%
%  <Synopsis>
%    [ signalselfclipping ] = selfclipping(signal,fs)
%
%  <Description>
%    Mute the transitions from voiced to unvoiced parts of the signal
%
%    INPUT:     signal = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ signalselfclipping ] = selfclipping(signal,fs);
%
%  <See Also>
%    voiunvoi_mod --> Limits of the voiced parts of a signal
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

[ segments ] = voiunvoi_mod( signal,25e-3*fs,0.005,0.95 );

% Clipping 0,1 s
clip = 0.1 *fs;

xend = signal;

% Mute the last 50 ms of each voiced part and the initial 50ms of of
% the successive unvoiced parts.
for i = 1: length(segments)
    
    punkt = segments (3,i);
    start = punkt - (clip/2);
    
    x1 = xend(1:start);
    x2 = 0*xend(start+1:start+clip);
    x3 = xend(start+clip+1:end);
    xend = [x1; x2; x3];
    
end

signalselfclipping = xend;

%-----------------------------------------------------------------------
% End of function selfclipping
%-----------------------------------------------------------------------