% function createFrameFeatureVectorDiffGabor creates a feature vector for a
% input frame. Feature vector contains mean values and standard deviation
% for two parts of a filtered face images (upper and lower part)(96 features)
% Features are sorted in the following way: 
% [meanUp1, meanLow1, meanUp2, meanLow2...sdevUp1, sdevLow1, sdevUp1, sdevLow1...] 
%
% @param frame                  input frame
% @param filterBank             gabor filter bank
% @return frameFeatureVector    frame feature vector [mean1...mean24, st devaiation1...st deviation24] 
%
function [frameFeatureVector] = createFrameFeatureVectorDiffGabor(diffImage, filterBank)

%creates a cell of 24 filtered images
frameFilteredImages = applyGabogFilterBankToFrame(diffImage, filterBank);

featuresMeanUp = zeros(1, 24);
featuresMeanLow = zeros(1, 24);
featuresDeviationUp = zeros(1, 24);
featuresDeviationLow = zeros(1, 24);



for i=1:24
    
    frameFilteredImages{i} = frameFilteredImages{i}(:);

    featuresMeanUp(i) = mean (frameFilteredImages{i}(1:size(frameFilteredImages{i})/2));
    featuresMeanLow(i) = mean (frameFilteredImages{i}(size(frameFilteredImages{i})/2:end));
    featuresDeviationUp(i) = std(frameFilteredImages{i}(1:size(frameFilteredImages{i})/2));
    featuresDeviationLow(i) = std(frameFilteredImages{i}(size(frameFilteredImages{i})/2:end));
          
end

frameFeatureVector = [featuresMeanUp featuresMeanLow featuresDeviationUp featuresDeviationLow];

end