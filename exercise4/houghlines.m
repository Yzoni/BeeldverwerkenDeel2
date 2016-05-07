function   houghlines(im, h, thresh)
% HOUGHLINES
%
% Function  takes an  image  and its  Hough  transform , finds  the
% significant  lines  and  draws  them  over  the  image
%
% Usage:   houghlines(im , h, thresh)
%
% arguments:
%           im      - The  original  image
%           h       - Its  Hough  Transform
%           thresh  - The  threshold  level to use in the  Hough  Transform
%                      to  decide  whether  an edge is  significant

% Get image size
[rows, cols] = size(im);

% The  maximum  possible  value  of rho.
rhomax = sqrt(rows^2 + cols ^2);

% The  increment  in rho  between  successive entries  in the  accumulator  
% matrix. Remember  we go  between +-rhomax.
drho = 2* rhomax /(nrho -1);

% The  increment  in theta  between  entries.
dtheta = pi/ntheta;

% Threshold the Hough Transformation
threshold_h = h;
threshold_h(h < thresh) = 0;

% Form labeled connected components
[L, nregions] = bwlabel(threshold_h);

for n = 1: nregions
    % Form a mask  for  each  region.
    mask = bwl == n;

    % Point -wise  multiply  mask by Hough  Transform
    region = mask .* h;    
    % to give  you an  image  with  just  one  region  of
    % the  Hough  Transform.

end
