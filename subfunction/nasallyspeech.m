function [ signalnasal ] = nasallyspeech(x,fs)

%  nasallyspeech --> Generation of nasally speech
%
%  <Synopsis>
%    [ signalnasal ] = nasallyspeech(x,fs)
%
%  <Description>
%    The nasally speech is generated by providing a multiplicative gain 10
%    to the frequency band 900-950 Hz and a gain 0,1 to frequencies below
%    700 Hz and above 1200 Hz. The transistions between the low and high
%    gains are linear in order to reduce artifacts.
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ signalnasal ] = nasallyspeech(x,fs);
%
%  Created by: Lucas Almeida
%-----------------------------------------------------------------------

% Fourier transform of the signal and resolution of the transform
fourier_transform = fft(x);
resolution = fs/length(x);

% Filter design:
% f < f1 and f > f4, attenuated
% f2 < f < f3, amplified
f1 = 700; 
f2 = 900;
f3 = 950;
f4 = 1200;

% fmx = fs - fx (mirror frequencies)
fm4 = fs - f4;
fm3 = fs - f3;
fm2 = fs - f2;
fm1 = fs - f1;

% Frequency indexes
i1 = round(f1/resolution);
i2 = round(f2/resolution);
i3 = round(f3/resolution);
i4 = round(f4/resolution);

im4 = round(fm4/resolution);
im3 = round(fm3/resolution);
im2 = round(fm2/resolution);
im1 = round(fm1/resolution);

% Gain
low_gain = 0.1;
high_gain = 10;

% Linear transition between low and high gains
up_gain = linspace(low_gain, high_gain, i2-i1)';
down_gain = linspace(high_gain, low_gain, i4-i3)';
upm_gain = linspace(low_gain, high_gain, im3-im4)';
downm_gain = linspace(high_gain, low_gain, im1-im2)';

% Gain application
fourier_transform(1:i1) = low_gain*fourier_transform(1:i1);
fourier_transform(i4+1:im4) = low_gain*fourier_transform(i4+1:im4);
fourier_transform(im1:end) = low_gain*fourier_transform(im1:end);

fourier_transform(i2+1:i3) = high_gain*fourier_transform(i2+1:i3);
fourier_transform(im3+1:im2) = high_gain*fourier_transform(im3+1:im2);

fourier_transform(i1+1:i2) = up_gain.*fourier_transform(i1+1:i2);
fourier_transform(i3+1:i4) = down_gain.*fourier_transform(i3+1:i4);
fourier_transform(im4+1:im3) = upm_gain.*fourier_transform(im4+1:im3);
fourier_transform(im2+1:im1) = downm_gain.*fourier_transform(im2+1:im1);

% Inverse fourier transfom
inverse_fourier = ifft(fourier_transform);

% Real part
xtest = real(inverse_fourier);

signalnasal = normalize(xtest,1);

%-----------------------------------------------------------------------
% End of function nasallyspeech
%-----------------------------------------------------------------------