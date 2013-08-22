% function applyGaborToImage performs convolution between image and gabor
% filter matrix
%
% @param image          input image
% @param gaborFilter    gabor filter matrix
% @return filteredImage filtered image
%
function [filteredImage] = applyGaborToImage(image, gaborFilter)

if (size(image,3)~=1)
    image = rgb2gray(image);
end
image=im2double(image);

if isa(image,'double')~=1 
    image = double(image);
end

ImagImage = conv2(image,double(imag(gaborFilter)),'same');
RealImage = conv2(image,double(real(gaborFilter)),'same');

filteredImage = sqrt(ImagImage.*ImagImage + RealImage.*RealImage);



end