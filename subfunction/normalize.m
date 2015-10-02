function [ normdata ] = normalize(data,peak)

%  normalize --> Normalization of a signal
%
%  <Synopsis>
%    [ normdata ] = normalize(data,peak)
%
%  <Description>
%    The data signal is normalized to a maximum absolute value peak 
%
%    INPUT:     data = signal vector
%               peak = maximum absolute value of the normalized data
%
%    Default Example: [ normdata ] = normalize(data,1)
%               The data signal is normalized to a vector with maximum 
%               absolute value 1
%
%  Created by: Friedemann Köster
%-----------------------------------------------------------------------

% Find the maximum absolute value.    
minimum = min(data);
maximum = max(data);

if abs(minimum) > maximum
    factor = peak / abs(minimum);
else
    factor = peak / maximum;
end

% Normalize the maximum value to 1 and all the others values accordingly
normdata = data .* factor;

%-----------------------------------------------------------------------
% End of function normalize
%-----------------------------------------------------------------------