function [ signalpoorlocalization ] = displacement(x,fs)

%  displacement --> Signal displacement from one ear to the other
%
%  <Synopsis>
%    [ signalpoorlocalization ] = displacement(x,fs))
%
%  <Description>
%    The signal level is higher on the right ear at the beggining of the
%    signal. The level difference changes linearly and ends with a higher
%    level on the left ear
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ signalpoorlocalization ] = displacement(x,fs);
%
%  <See Also>
%    normalize --> Normalization of a signal
%
%  Created by: Lucas Almeida / Friedemann Köster
%-----------------------------------------------------------------------

N = length(x);

% Right ear signal starts louder
xright = linspace(20,1,N)'.*x;

% Left ear signal ends 10 louder
xleft = linspace(1,20,N)'.*x; 

xright = normalize(xright,0.5);
xleft = normalize(xleft,0.5);

signalpoorlocalization = [xleft,xright];

%-----------------------------------------------------------------------
% End of function displacement
%-----------------------------------------------------------------------