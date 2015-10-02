function [ echo ] = echo_mod (signal,fs,delay,number)

%  echo_mod --> Addition of echo to the speech signal
%
%  <Synopsis>
%    [ echo ] = echo_mod (signal,delay,fs,number)
%
%  <Description>
%    Echo is added to the signal, with one or more delayed wave fronts
%    (number)
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               delay = time between first wave front and echo in [ms]
%               number = how many times the echo is heard
%
%    Default Example: [ echo ] = echo_mod (x,200,fs,2);
%               Two echo wave fronts are added to the signal, with 0,2s and
%               0,4s of delay.
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

% Calculation of number of zeros between two impulses
zeroVec = zeros(1, (fs*(delay/1000))-1);

% Generation of the impulse response
if number == 1
    impulseResponse = [ 1 zeroVec 0.5 ]';
elseif number == 2
    impulseResponse = [ 1 zeroVec 0.5 zeroVec 0.2 ]';
else
    impulseResponse = [ 1 zeroVec 0.5 zeroVec 0.2 zeroVec 0.05 ]';
end

% Convolution and normalization
echo = normalize(conv(signal,impulseResponse),1);

%-----------------------------------------------------------------------
% End of function echo
%-----------------------------------------------------------------------