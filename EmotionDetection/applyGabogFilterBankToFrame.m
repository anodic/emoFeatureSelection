% function applyGabogFilterBankToFrame creates filtered image for a frame
% for each filter in the filterbank
%
% @param frame                  input image
% @param filterBank             gabor filter bank
% @return frameFilteredImages   cell with 24 filtered images from 1 frame
%
function [frameFilteredImages] = applyGabogFilterBankToFrame(frame, filterBank)

frameFilteredImages = cell(1,24);

for i=1:24
 
     frameFilteredImages{i}=applyGaborToImage(frame, filterBank{i});
   
%       name = ['filteredImage' int2str(i) '.jpg'];
%        figure, image(frameFilteredImages{i}); colormap gray; axis equal;
%       imwrite (frameFilteredImages{i}, ['D:\research\emotionDetection\gaborFilterResults\f025S5\', name],'jpg');
    
end


end