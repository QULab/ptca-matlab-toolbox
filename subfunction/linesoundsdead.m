function [ signalsoundsdead ] = linesoundsdead(signal)

%  linesoundsdead --> Nullification of low amplitude values
%
%  <Synopsis>
%    [ signalsoundsdead ] = linesoundsdead(signal)
%
%  <Description>
%    All the points of the signal with absolute value smaller than 12e-4
%    are nullified
%
%    INPUT:     signal = a speech signal vector
%
%    Default Example: [ signalsoundsdead ] = linesoundsdead(signal);
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

for i=1:length(signal)
    
    if (abs(signal(i)) <= 12e-4)
        signal(i)= 0;
    end

end

signalsoundsdead = signal;

%-----------------------------------------------------------------------
% End of function linesoundsdead
%-----------------------------------------------------------------------