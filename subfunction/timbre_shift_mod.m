function [ output ] = timbre_shift_mod(x,fs,shift)

%  timbre_shift --> Shifting the timbre of the speech signal
%
%  <Synopsis>
%    [ output ] = timbre_shift_mod(x,fs,shift)
%
%  <Description>
%    The signal spectrum is shifted to higher/lower frequencies
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%               shift = frequency shift in [Hz] to right/left (+/-).
%
%    Default Example: [ output ] = timbre_shift_mod(x,fs,-300);
%               The signal spectrum is shifted 300 Hz to the left
%
%  Created by: Friedemann Köster
%   Edited by: Lucas Almeida
%-----------------------------------------------------------------------

xx = fft(x);

% fft resoltution
resolution = fs/length(xx);

% Frequency shift
freq = round(shift/resolution);

xxx = zeros(length(xx),1);

% Shift to the right if positive or to the left if negative
if freq >= 0
    xxx(freq+1:end) = xx(1:end-freq);
elseif freq < 0
    freq1 = freq*(-1);
    xxx(1:end-freq1) = xx(freq1+1:end);
end

y = ifft(xxx);

output = real(y);
%-----------------------------------------------------------------------
% End of function timbre_shift_mod
%-----------------------------------------------------------------------