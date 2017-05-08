function [ h, edges ] = hough(im, Thresh , nrho , ntheta)
% HOUGH
%
% Function  takes a grey  scale  image , constructs  an edge  map by  applying
% the  Canny  detector , and  then  constructs a Hough  transform  for  finding
% lines in the  image.
%
% Usage:   h = hough(im , Thresh , nrho , ntheta)
%
% arguments:
%               im      - The  grey  scale  image to be  transformed
%               Thresh  - A 2 -vector  giving  the  upper  and  lower
%                         hysteresis  threshold  values  for  edge()
%               nrho    - Number  of  quantised  levels  of rho to use
%               ntheta  - Number  of  quantised  levels  of  theta to use
%
% returns;
%               h       - The  Hough  transform

% Get image size
[rows, cols] = size(im);

% Get the edges of the image using canny edge detection
edges = edge(im, 'canny', Thresh);

% The  maximum  possible  value  of rho. (diagonal of the image)
rhomax = sqrt(rows^2 + cols ^2);	

% The  increment  in rho  between  successive entries  in the  accumulator  
% matrix. Remember  we go  between +-rhomax.
drho = 2 * rhomax / (nrho - 1);

% The  increment  in theta  between  entries.
dtheta = pi / ntheta;

% Array  of theta  values  across  the accumulator  matrix.
thetas = 0: dtheta :(pi-dtheta );

% Initiate h
h = zeros(nrho, ntheta);
% for  each x and y of  nonzero  edge  values:
for x = 1:cols
    for y = 1:rows
        if edges(y, x) ~= 0
            % for  each  theta in  thetas:
            for theta = thetas
                % rho = evaluate  (1)
                rho = x * sin(theta) - y * cos(theta);
                % To  convert a value of rho or  theta
                % to its  appropriate  index in the  array  use:
                rhoindex = round(rho/drho + nrho /2);
                thetaindex = round(theta/dtheta + 1);
                h(rhoindex, thetaindex) = h(rhoindex, thetaindex) + 1;
            end
        end
    end
end
