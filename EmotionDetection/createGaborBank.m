% function createGaborBank creates a filter bank
% 
%@return filterBank
%
function [gaborFilterBank] = createGaborBank()

% from Štruc, Pavešiæ, "Principal Gabor Filters for Face Recognition" f =
% f= 0.25, Sx = Sy = sqrt(2)
f = 1;
Sx = 10;
Sy = 10;
gaborFilterBank = cell(1,24);
index=1;

% orientations 0,30,60,90,120,150
for i=0:30:150
    j=1;
    % f, f/2, f/4, f/8
    while j < 9
                       
        gaborFilterBank{index}=createGaborFilter2(j,j,f/j,i*pi/180);
        
%          name = ['filter' int2str(index) '.jpg'];
%          imwrite (gaborFilterBank{index}, ['D:\research\emotionDetection\gaborFilterBank\f025S5\', name],'jpg');
         
        index = index +1;
        j=j*2;
        
        
        
    end
    
    save 'gaborFilterBank.mat' gaborFilterBank
    
end