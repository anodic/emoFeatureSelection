% function createEmotionFeatureVector creates a set of feature vectors for
% each emotion frame set
%
% @param emotionDirectory          input emotion directory
% @param filterBank                filter matrix bank
% @return emotionFeatureVectors    gabor filter matrix
%
function [diffFeatureVectors] = diffBetweenVectors(emotionFeatureVectors)

for i=1:size(emotionFeatureVectors,1)-1
    
    diffFeatureVectors{i} = emotionFeatureVectors{i} - emotionFeatureVectors{i+1};
    
    meanDiff(i) = mean(diffFeatureVectors{i})
    
    
end