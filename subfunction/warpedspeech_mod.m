function [ warped_speech ] = warpedspeech_mod (x,fs)

%  warpedspeech --> Generation of warped speech
%
%  <Synopsis>
%    [ warped_speech ] = warpedspeech_mod (x,fs)
%
%  <Description>
%    Generation of warped speech by resampling 25% of the voiced segments
%    of the speech signal
%
%    INPUT:     x = a speech signal vector
%               fs = corresponding sampling frequency
%
%    Default Example: [ warped_speech ] = warpedspeech_mod(x,fs);
%
%  <See Also>
%    voiunvoi_mod --> Limits of the voiced parts of a signal
%
%  Created by: Falk Schiffner
%-----------------------------------------------------------------------

% Limits of the voiced parts of the signal
[ segments ] = voiunvoi_mod(x,25e-3*fs,0.005,0.95);
l = length(segments);

% Select randomly some of the voiced segments
num_seg_speed_change = round(l*0.25);
aux = randperm(l);
aux = aux(1:num_seg_speed_change);
r2 = sort(aux);

for i = num_seg_speed_change:-1:1
    r3 = r2(i);
    b(1:segments(4,r3)) = x(segments(2,r3):segments(3,r3)-1);
    
    % Decimate or interpolate each of the selected segments
    g = randi([1 10]);
    if g <=5
        bb = resample(b,3,2);
    elseif g>5
        bb = resample(b,2,3);
    end
    clear b
    
    % Substitute the resampled segments
    x = [x(1:segments(2,r3)); bb'; x(segments(3,r3):end)];
end

warped_speech = x;

%-----------------------------------------------------------------------
% End of function warpedspeech_mod
%-----------------------------------------------------------------------