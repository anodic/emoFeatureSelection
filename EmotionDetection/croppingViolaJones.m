% function croppingViolaJones takes an image, does the Viola Jones
% algorithm and returns the cropped image
% @param  image          input image
% @return croppedImage   cropped image               
%
function [croppedImage] = croppingViolaJones(image)


   tmpImage = imresize(image, [240 320]);
           
   result = DetectHumanFaces (tmpImage);
   croppedImage = imcrop(tmpImage, [result(1) result(2) result(3) result(4)]);
     
    
end
