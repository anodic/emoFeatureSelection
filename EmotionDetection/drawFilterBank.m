% function drawFilterBank draws images of filters in the filter bank
% 
% @param filterBank    gabor filter bank
%
function [] = drawFilterBank(filterBank)

for i=1:24
  
        figure, imshow(filterBank{i})
   
end

end