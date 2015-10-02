function [ pink ] = pinknoise(fs,T)

%  pinknoise --> Generation of pink noise
%
%  <Synopsis>
%    [ pink ] = pinknoise(fs,T)
%
%  <Description>
%    Pink noise is generated through white noise by making the spectral
%    energy proportional to the inverse of the frequency
%
%    INPUT:     fs = corresponding sampling frequency
%               T = duration of noise in [s]
%
%    Default Example: [ pink ] = pinknoise(fs,15);
%               Pink noise with 15 seconds of duration
%
%  <See Also>
%    whitenoise --> Generation of white noise
%
%  Created by: Lucas Almeida
%-----------------------------------------------------------------------

% White noise
[ white ] = whitenoise(fs,T);

% Number of samples
N = length(white);

% White noise spectrum
White = fft(white);

% No DC level
White(1) = 0;

% No energy at Nyquist frequency
White(fs/2+1) = 0;

% Frequency vector
f(1:N/2+1,1) = (1:1:N/2+1)*fs/N;

% Energy proportional to 1/f
Pink = White(1:N/2+1)./sqrt(f);

% Flip the spectrum
Pink = [Pink; flipud(real(Pink(2:end-1)) - 1i*imag(Pink(2:end-1)))];

% Pink noise
pink = 12*real(ifft(Pink));

%-----------------------------------------------------------------------
% End of function pinknoise
%-----------------------------------------------------------------------