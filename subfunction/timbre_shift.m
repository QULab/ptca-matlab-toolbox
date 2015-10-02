function [ signaltimbrevaries ] = timbre_shift(x,fs,T,shift)

%  timbre_shift --> Shifting the timbre of the speech signal
%
%  <Synopsis>
%    [ signaltimbrevaries ] = timbre_shift(x,fs,T,shift)
%
%  <Description>
%    The signal is divided into windows of duration T, some of the windows
%    are shifted in the spectral domain
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               T = duration of the shifted windows in [s]
%               shift = maximum possible frequency shift in [Hz]
%
%    Default Example: [ signaltimbrevaries ] = timbre_shift(x,fs,0.5,150);
%               The signal is divided into windows of duration 0,5 s.
%               Each one of the windows may have its frequency shifted by
%               until 150 Hz
%
%  Created by: Friedemann Köster
%   Edited by: Lucas Almeida
%-----------------------------------------------------------------------

% Duration of the windows 
window = round(T*fs);

% fft resoltution
resolution = fs/window;

% Frequency shift
factor = shift/resolution;

% Number of windows
n = ceil(length(x)/window);

% Split the speech signal into n windows
for i = 1:n-1
    X{i,1} = x((i-1)*window+1:i*window);
end
X{n,1} = x((n-1)*window+1:end);

% Fourier Tranform for each segment of the speech signal
for i = 1:n
    X{i,2} = fft(X{i,1});
end

% Check if n is even
aux = 0;
if rem(n,2)
    n = n-1;
    aux = 1;
end

% The frequency shift is between 0 and "shift" Hz
% The odd windows are not shifted
b = rand(n,1);
m = (repmat([0 1], 1, n/2))';
mm = b.*m;
bb = round(factor*mm);

% Last window
if aux == 1
    n = n+1;
    bb(n) = 0;
end    

% Shift pitch for each window
% Inverse Fourier Transfom
y=[];
for i = 1:n
X{i,3} = zeros(length(X{i,2}),1);    
X{i,3}(bb(i)+1:end) = X{i,2}(1:end-bb(i));
X{i,4} = ifft(X{i,3});
y = [y; X{i,4}];
end

signaltimbrevaries = real(y);

%-----------------------------------------------------------------------
% End of function timbre_shift
%-----------------------------------------------------------------------