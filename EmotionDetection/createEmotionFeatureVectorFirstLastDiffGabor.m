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
function [emotionFeatureVector] = createEmotionFeatureVectorFirstLastDiffGabor(emotionDirectory, filterBank)

%get list of frames in emotion folder
listOfFrames = dir(emotionDirectory);

FirstFrameName = listOfFrames(3).name;
LastFrameName = listOfFrames(size(listOfFrames,1)).name;

FirstFrameName2 = ['\', FirstFrameName];
LastFrameName2 = ['\', LastFrameName];

FirstFrame = imread([emotionDirectory FirstFrameName2]);
LastFrame = imread([emotionDirectory LastFrameName2]);
%figure, imshow(FirstFrame);
%figure, imshow(LastFrame);

diffFirstLast = imabsdiff (FirstFrame, LastFrame);


emotionFeatureVector = createFrameFeatureVectorDiffGabor(diffFirstLast, filterBank);


end