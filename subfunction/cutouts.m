function [ signalcutout ] = cutouts(x,fs)

%  cutouts --> Elimination of one-second parts of a speech file array
%
%  <Synopsis>
%    [ signalcutout ] = cutouts(x,fs)
%
%  <Description>
%    Hush for a second, the voiced parts of the signal with duration 
%    greater than one third of second
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ signalcutout ] = cutouts(x,fs);
%
%  <See Also>
%    voiunvoi_mod --> Limits of the voiced parts of a signal
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

% Limits of the voiced parts of the signal
[ segments ] = voiunvoi_mod(x,25e-3*fs,0.005,0.95);

% Find the voiced parts with length greater than 1/3 second.
b = find(segments(4,:)>(fs/3));

xend = x;

% Mute the last 0,5s of the selected voiced parts and the initial 0,5s of
% the successive unvoiced parts.
for i = 1: length(b)
    
    punkt = segments (3,b(1,i));
    start = punkt - (fs/2);
    
    x1 = xend(1:start);
    x2 = 0*xend(start+1:start+fs);
    x3 = xend(start+fs+1:end);
    xend = [x1; x2; x3];
    
end

signalcutout = xend;

%-----------------------------------------------------------------------
% End of function cutouts
%-----------------------------------------------------------------------