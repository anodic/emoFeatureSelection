% function createFrameFeatureVectorabor creates a feature vector for a
% input frame. Feature vector contains mean values and standard deviation
% for each filtered images (48 features)
%
% @param frame                  input frame
% @param filterBank             gabor filter bank
% @return frameFeatureVector    frame feature vector [mean1...mean24, st devaiation1...st deviation24] 
%
function [frameFeatureVector] = createFrameFeatureVector(frame, filterBank)

%creates a cell of 24 filtered images
frameFilteredImages = applyGabogFilterBankToFrame(frame, filterBank);

featuresMean = zeros(1, 24);
featuresDeviation = zeros(1, 24);

for i=1:24
    
    frameFilteredImages{i} = frameFilteredImages{i}(:);

    featuresMean(i) = mean (frameFilteredImages{i});
    featuresDeviation(i) = std(frameFilteredImages{i});
          
end

frameFeatureVector = [featuresMean featuresDeviation];

end