%montageGaborImages
function [montagedGaborImgs] = montageGaborImages(gaborImages)

%multiFrameImg=cat(4,gaborImages{1});
gaborImages{25}=zeros(size(gaborImages{1},1),size(gaborImages{1},2));
% for i=2:size(gaborImages,2)
%     multiFrameImg = cat(4,multiFrameImg,gaborImages{i});
% end

counter = 1;
for j=0:4
montagedImages{j+1}=[gaborImages{j*5+1}];
for i = 2:5
   
        montagedImages{j+1}=[montagedImages{j+1},gaborImages{j*5+i}];       
        
   
end
end

montagedGaborImgs = [ montagedImages{1}];
for i= 2:5
    montagedGaborImgs = [ montagedGaborImgs; montagedImages{i}];
end

% montagedImages = montage(multiFrameImg);
% 
% saveas(montagedImages,'filename.png');
% 
% montagedGaborImgs = 'filename.png';

end