function [ voi ] = voiunvoi(x,N,Pth,Zth)

%  voiunvoi --> Voiced/unvoiced segmentation using a sliding window
%
%  <Synopsis>
%    [ voi ] = voiunvoi(x,N,Pth,Zth)
%
%  <Description>
%    An initial voiced/unvoiced segmentation based on short-time
%    power Px and zero crossing Zx measures obtained in sliding
%    windows of length N. The middle sample in the window is labeled
%    voiced (voi=1) if Px/max(Px) > Pth and Zx < Zth
%
%    INPUT:     x = a speech signal vector
%               N = length of sliding windows
%               Pth = short-time power threshold (must be between 0 and 1)
%               Zth = zero crossing measure threshold (must be between 0
%               and 1)
%
%    Default Example: [ voiced ] = voiunvoi(x,25e-3*fs,0.005,0.95);
%               The short-time power and zero-crossing measures are
%               calculated for each sample for the last 25ms.
%               The samples are considered voiced only if:
%               Px/max(Px) > 0.005 and Zx < 0.95
%
%  <See Also>
%    stpower     --> Short-term power computation in a sliding window.
%    stzerocross --> Short-term zero crossing measure in a sliding window.
%
%  Created/Modified by: Friedemann Köster
%-----------------------------------------------------------------------

% Check the required input arguments.
if (nargin < 4)
  error('Not enough input arguments.')
end

if (prod(size(Pth))>1) | (Pth(1,1)>1) | (Pth(1,1)<0)
  error('Requires Pth to be a scalar between 0 and 1.')
end
if (prod(size(Zth))>1) | (Zth(1,1)>1) | (Zth(1,1)<0)
  error('Requires Zth to be a scalar between 0 and 1.')
end

% Short-time power Px and zero crossing Zx measures.
Px = stpower(x,N);
Zx = stzerocross(x,N);

% Compare estimates with threshold values.
voi = (Px>Pth*max(Px)) & (Zx<Zth);

% Shift the voi-flag N/2 samples to the left (middle sample in window).
voi = [voi(fix(N/2)+1:length(voi));voi(length(voi))*ones(fix(N/2),1)];

%-----------------------------------------------------------------------
% End of function voiunvoi
%-----------------------------------------------------------------------