function [ segments ] = voiunvoi_mod(x,N,Pth,Zth)

%  voiunvoi_mod --> Limits of the voiced parts of a signal
%
%  <Synopsis>
%    [ segments ] = voiunvoi_mod(x,N,Pth,Zth)
%
%  <Description>
%    Information about the voiced parts of the signal through a 4 line
%    vector:
%       Line 1: Helpline, does not contain relevant information
%       Line 2: Indexes of the beginning of the voiced parts
%       Line 3: Indexes of the end of the voiced parts
%       Line 4: Length of the voiced parts

%    The voiced/unvoiced segmentation is done with the voiunvoi function,
%    which is based on short-time power Pth and zero crossing Zth measures
%    obtained in sliding windows of length N. The middle sample in the 
%    window is labeled voiced (voi=1) if Px/max(Px) > Pth and Zx < Zth
%
%    INPUT:     x = a speech signal vector
%               N = length of sliding windows
%               Pth = short-time power threshold (must be between 0 and 1)
%               Zth = zero crossing measure threshold (must be between 0
%               and 1)
%
%    Default Example: [ segments ] = voiunvoi_mod( x,25e-3*fs,0.005,0.95 );
%               The short-time power and zero-crossing measures are
%               calculated for each sample for the last 25ms.
%               The samples are considered voiced only if:
%               Px/max(Px) > 0.005 and Zx < 0.95
%
%  <See Also>
%    voiunvoi --> Voiced/unvoiced segmentation using a sliding window.
%
%  Created by: 
%   Edited by: Lucas Almeida
%-----------------------------------------------------------------------

voi = (voiunvoi(x,N,Pth,Zth));

% Indexes of the voiced parts of the signal
n = find(voi);

% Line 1: Helpline, indexes of n where there are gaps between voiced parts
m = 1;
for i=1:length(n)-1
    if n(i)+1 ~= n(i+1)
        part1(1,m) = i;
        m = m+1;
    end
end

% First values of the lines 2 and 3
part1(2,1)=n(1,1);
part1(3,1)=n(part1(1,1),1);

% Line 2: Beginning of the voiced parts
g=2;
for i=1:length(part1(1,:))
    part1(2,g)=n(part1(1,i)+1,1);
    g = g+1;
end

% Line 3: End of the voiced parts
f = 2;
for i=1:(length(part1(1,:))-2)
    part1(3,f)=n(part1(1,i+1),1);
    f = f+1;
end

clear i f g

% Line 4: Length of the voiced parts
for i=1:(length(part1(1,:))-1)
    part1(4,i)=part1(3,i)-part1(2,i);
end

% Last values of the lines 1, 3 and 4
part1(1,m) = length(n);
part1(3,m) = n(end);
part1(4,m) = part1(3,m)-part1(2,m);

segments = part1;

%-----------------------------------------------------------------------
% End of function voiunvoi_mod
%-----------------------------------------------------------------------