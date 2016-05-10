function [x1, y1, x2 , y2] = thetarho2endpoints(theta ,rho ,rows ,cols)
%THETARHO2ENDPOINTS Converts theta and rho parameters to 2 xy coordinates
    
    % lines horizontal
    x1 = 0;
    y1 = (-rho) / cos(theta);
    
    x2 = cols;
    y2 = (-rho + x2 * sin(theta)) / cos(theta);
    
    % lines almost vertical
    if abs(y1-y2) > cols
        y1 = 0;
        x1 = (rho) / sin(theta);
        
        y2 = rows;
        x2 = (rho + y2 * cos(theta)) / sin(theta);
    end
end

