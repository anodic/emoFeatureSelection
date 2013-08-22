% function createEmotionFeatureVector creates a set of feature vectors for
% each emotion frame set
%
% @param emotionDirectory          input emotion directory
% @param filterBank                filter matrix bank
% @return emotionFeatureVectors    gabor filter matrix
%
function [emotionFeatureVectors] = createEmotionFeatureVector(emotionDirectory, filterBank)

%get list of frames in emotion folder
listOfFrames = dir(emotionDirectory);

emotionFeatureVectors = cell(size(listOfFrames,1)-2 ,1);

for i=3:size(listOfFrames,1)
    
    %get frame image name
    frameName = listOfFrames(i).name;
    
    %check if the file is an jpg image
    l = length(frameName);
    if(~strcmp(frameName(l-2:l), 'jpg'))
        continue;
    end
    
    frameName2 = ['\', frameName];
    
    %get frame
    frame = imread([emotionDirectory frameName2]);
    
    %calculate feature vector for that frame and add it to set of vectors
    emotionFeatureVectors{i-2} = createFrameFeatureVector(frame, filterBank);
    
end


end