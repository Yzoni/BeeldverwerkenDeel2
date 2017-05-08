function [ lines, coordinates ] = houghlines(im, h, thresh)
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

%%%%%%%%%%%%%%%%%%%%%%

% Get image size
[rows_im, cols_im] = size(im);
[rows_h, cols_h] = size(h);

h = imdilate(h, strel('rectangle',[2,2]));

% The  maximum  possible  value  of rho. (diagonal of the image)
rhomax = sqrt(rows_im^2 + cols_im ^2);

% The  increment  in rho  between  successive entries  in the  accumulator  
% matrix. Remember  we go  between +-rhomax.
nrho = rows_h;
drho = 2 * rhomax / (nrho - 1);

% The  increment  in theta  between  entries.
ntheta = cols_h;
dtheta = pi / ntheta;

% Threshold the Hough Transformation
threshold_h = h;
threshold_h(h < thresh) = 0;

% Form labeled connected components
[bwl, nregions] = bwlabel(threshold_h);

% Init lines
lines = zeros(nregions, 3);

coordinates = zeros(nregions, 4);

for n = 1:nregions
    % Form a mask  for  each  region.
    mask = bwl == n;
    
    % Point -wise  multiply  mask by Hough  Transform
    region = mask .* h;    
    % to give  you an  image  with  just  one  region  of the  Hough
    % Transform.

    % Get rows and column index of max value
    [~, idx] = max(region(:));
    % Get the indices for the row and column with max value
    [row, col] = ind2sub(size(region), idx);
    
    % Convert indices back to theta and rho
    rho = (row-nrho/2)*drho;
    theta = (col-1)*dtheta;

    
    % Generetate two points from theta and rho
    [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, rows_im, cols_im);
    
    coordinates(n, :) = [x1, x2, y1, y2];
    
    % Create a line of homogenous coordinates
    hom_coordinates = cross([y1; x1; 1], [y2; x2; 1]);
    
    % Normalize homogeneous coordinates
    hom_coordinates = hom_coordinates ./ sqrt(hom_coordinates(1)^2 + hom_coordinates(2)^2);
    hom_coordinates = hom_coordinates ./ hom_coordinates(3);
    
    % Save the coordinates as a (nregions × 3) matrix
    lines(n, :) = hom_coordinates;
end
