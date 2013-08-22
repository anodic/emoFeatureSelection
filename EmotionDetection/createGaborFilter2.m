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
function [gaborFilter] = createGaborFilter2(Sx,Sy,f,theta)

sz_x=6*Sx+1;
sz_y=6*Sy+1;

[x y]=meshgrid(-fix(sz_x/2):fix(sz_x/2),fix(-sz_y/2):fix(sz_y/2));

% Rotation 
x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);

gaborFilter=exp(-.5*(x_theta.^2/Sx^2+y_theta.^2/Sy^2)).*cos(2*pi*f*x_theta);
end
