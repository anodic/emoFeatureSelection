% function createEmotionFeatureVectorFirstLast creates a feature vector for
% the emotion sequence. It takes first (neutral) F1 and last(max)F2 frame and
% applies gabor filters on them. Then creates a feature vector FV1 for first frame
% and FV2 for the second frame. After that emotion feature vector is created. 
% Emotion feature vector contains [(FV1) (FV2) (FV1-FV2) (FV1./FV2) ((FV1-FV2)./FV1)]
% 
%
% @param emotionDirectory                   input emotion directory
% @param filterBank                         filter matrix bank
% @return emotionFeatureVectorsFirstLast    emotion feature vector
%
function [emotionFeatureVector] = LDOSPerAffCreateEmotionFeatureVectorNeutralTopFive(emotionDirectory, neutralFrameName, filterBank, version)

%get list of frames in emotion folder
listOfFrames = dir(emotionDirectory);

emotionFeatureVectorsFirstLast = cell(5 ,1);

if(size(listOfFrames,1)<7)
    currentFrameName  = listOfFrames(3).name;
else
    currentFrameName  = listOfFrames(size(listOfFrames,1)+1-version).name;
end

currentFrameName2 = ['\', currentFrameName];

neutralFrame = imread(neutralFrameName);
currentFrame = imread([emotionDirectory currentFrameName2]);
%figure, imshow(FirstFrame);
%figure, imshow(LastFrame);

emotionFeatureVectorsFirstLast{1} = createFrameFeatureVector(neutralFrame, filterBank);
emotionFeatureVectorsFirstLast{2} = createFrameFeatureVector(currentFrame, filterBank);

    
emotionFeatureVectorsFirstLast{3} = emotionFeatureVectorsFirstLast{1} - emotionFeatureVectorsFirstLast{2};
emotionFeatureVectorsFirstLast{4} = emotionFeatureVectorsFirstLast{1} ./ emotionFeatureVectorsFirstLast{2};
emotionFeatureVectorsFirstLast{5} = (emotionFeatureVectorsFirstLast{1} - emotionFeatureVectorsFirstLast{2})./emotionFeatureVectorsFirstLast{1};


emotionFeatureVector = [emotionFeatureVectorsFirstLast{1} emotionFeatureVectorsFirstLast{2} emotionFeatureVectorsFirstLast{3} emotionFeatureVectorsFirstLast{4} emotionFeatureVectorsFirstLast{5}];




end