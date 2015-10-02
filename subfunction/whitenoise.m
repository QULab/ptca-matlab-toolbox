function [ white ] = whitenoise(fs,T)

%  whitenoise --> Generation of white noise
%
%  <Synopsis>
%    [ white ] = whitenoise(fs,T)
%
%  <Description>
%    White noise is generated randomly with duration (T) for a
%    corresponding sampling frequency (fs)
%
%    INPUT:     fs = corresponding sampling frequency
%               T = duration of noise in [s]
%
%    Default Example: [ white ] = whitenoise(fs,15);
%               White noise with 15 seconds of duration
%
%  Created by: Lucas Almeida
%-----------------------------------------------------------------------

% Number of samples
N = T*fs;

% Ensure an even number of samples
N = 2*round(N/2);

% White noise
white = rand(N,1)-0.5;

%-----------------------------------------------------------------------
% End of function whitenoise
%-----------------------------------------------------------------------