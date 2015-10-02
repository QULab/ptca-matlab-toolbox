function [ audio_out ] = bandfilter(audiodata,fs,fu,fo,filterorder)

%  bandfilter --> Filtering an audio file by a butterworth filter
%
%  <Synopsis>
%    [ audio_out ] = bandfilter(audiodata,fs,fu,fo,filterorder)
%
%  <Description>
%    The audio signal is filtered by a butterworth filter with order
%    filterorder, the cutoff frequencies ares fu and fo
%
%    INPUT:     audiodata = an audio signal vector
%               fs = corresponding sampling frequency
%               fu = lower cutoff frequency in [radians]
%               fo = upper cutoff frequency in [radians]
%               filterorder = order of the filter
%
%    Default Example: [ audio_out ] = bandfilter(audiodata,fs,50*2*pi,500*2*pi,4);
%               An audio filtered with a butterworth filter of order 4 and 
%               cutoff frequencies 50 and 500 Hz
%
%  Created by: Friedemann Köster / Falk Schiffner
%-----------------------------------------------------------------------

% Lower and upper limits of the bandpass
band = [fu, fo]/(fs);

% [Coeff_B Coeff_A] = butterworth(filterorder, band, 'bandpass')
[B1, A1] = butter(filterorder, band);

% Filtering input with filter
audio_out = filter (B1, A1, audiodata);

%-----------------------------------------------------------------------
% End of function bandfilter
%-----------------------------------------------------------------------