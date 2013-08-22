%function createGaborFilter creates a gabor filter matrix
%
%                            -1     x' ^     y'  ^             
% G(x,y,theta,f) =  exp ([----{(----) 2+(----) 2}])*cos(2*pi*f*x');
%                             2    sx'       sy'
% x' = x*cos(theta)+y*sin(theta);
% y' = y*cos(theta)-x*sin(theta);


% @param Sx                 Variances along x 
% @param Sy                 Variances along x
% @param f                  The frequency of the sinusoidal function
% @param theta              The orientation of Gabor filter

% @return gaborFilter       The output filter as described above
%
function [gaborFilter] = createGaborFilter(Sx,Sy,f,theta)


for x = -fix(Sx):fix(Sx)
    for y = -fix(Sy):fix(Sy)
        xPrime = x * cos(theta) + y * sin(theta);
        yPrime = y * cos(theta) - x * sin(theta);
        gaborFilter(fix(Sx)+x+1,fix(Sy)+y+1) = exp(-.5*((xPrime/Sx)^2+(yPrime/Sy)^2))*cos(2*pi*f*xPrime);
    end
end
