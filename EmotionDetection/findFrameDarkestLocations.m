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
function [loc] = findFrameDarkestLocations(image)

meanIntensity = mean(mean(image))

imageVector = reshape(image, 1,120*120);

sortedImageVector = sort(imageVector, 'descend')


end