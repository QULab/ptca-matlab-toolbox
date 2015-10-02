function [ signallv ] = speechlevelfluc(signal,fs)

%  speechlevelfluc --> Level fluctuations on a speech array
%
%  <Synopsis>
%    [ signallv ] = speechlevelfluc(signal,fs)
%
%  <Description>
%    The signal is divided into blocks
%    The blocks are alternately amplified and attenuated
%
%    INPUT:     signal = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ signalslf ] = speechlevelfluc(signal,fs);
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

x = signal;
m = length(x);

% Length of the blocks in which the signal is divided 
h = (round(((m/fs)/10).*100)/100)*fs;

% Number of blocks
k = floor(m/h);

% The blocks are amplified and attenuated
for i = 0:1:k-1
   if rem(i,2)
        x1(i*h+1:(i+1)*h) =0.5*x(i*h+1:(i+1)*h);
   else
        x1(i*h+1:(i+1)*h) =2.5*x(i*h+1:(i+1)*h);    
   end
end

% Last block
if rem(i,2)
    x1(k*h:m) =0.5*x(k*h:m);
else
    x1(k*h:m) =1.5*x(k*h:m);    
end

out = x1';
signallv = out;

%-----------------------------------------------------------------------
% End of function speechlevelfluc
%-----------------------------------------------------------------------