function [ signalfadeout ] = fadeout(x,fs,Tend,Tbegin,Tout)

%  fadeout --> Fading out of a speech file
%
%  <Synopsis>
%    [ signalfadeout ] = fadeout(x,fs,Endwert,Tbegin,Tout)
%
%  <Description>
%    The speech signal fades out linearly at a predefined time (Tbegin)
%    until reach a certain percentage (Endwert) some seconds (Tout) later.
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               Endwert = value in [%] on what level the fade will stop
%               Tbegin = value in [s] when the fade should start
%               Tout = value in [s] duration of the fade
%
%    Default Example: [ signalfadeout ] = fadeout(x,fs,0.2,2,1);
%               A fadeout that starts after two seconds with a duration of
%               one second and will stop at 20% of the actual speech-level
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

% T in [s] when the fading should begin
signalTbegin = round(Tbegin*fs);

% T in [s] how long the fading should last
tout = Tout*fs;
signalTout = round(Tbegin*fs+tout);

% Unchanged part
out1 = x(1:signalTbegin,1);

% Faded part
outfade = x(signalTbegin+1:signalTout,1);

% Rest of the signal
out2 = Tend*x(signalTout+1:end,1);

% The real fading
prozent = 1 - Tend;
differ = prozent / length (outfade);
for i = 1:length(outfade)
    outfade(i,1) = outfade(i,1)*(1-(i*differ));
end

signalfadeout = [out1;outfade;out2];

%-----------------------------------------------------------------------
% End of function fadeout
%-----------------------------------------------------------------------