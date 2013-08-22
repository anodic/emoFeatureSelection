% function addEmotionFeatureVectorInDataSet calculates emotion feature
% vector and adds it to dataSetStruct. 
%
% @param dataSetPath           data set path
% @return  dataSetStruct       data set struct with added vectors
%
function [dataSetStruct] = addEmotionFeatureVectorInDataSetStruct(dataSetPath)


% loading the dataSetStruct 
structLocation = [dataSetPath '\' 'dataSetStruct.mat'];
load (structLocation)

% load gabor filter bank
load gaborFilterBank.mat


%creating feature vectors and adding them to a struct
for i=1:size(dataSetStruct,2)
    
    personFolder = dataSetStruct(i).personFolder;
    emotionFolder = dataSetStruct(i).emotionFolder;
    fulPath = [dataSetPath '\' personFolder '\' emotionFolder];
    
    emotionFeatureVector = createEmotionFeatureVectorFirstLastDiffGabor(fulPath, gaborFilterBank);
    
    statement = ['Vector ' int2str(i) ' of ' int2str(size(dataSetStruct,2)) ' calculated!'];
    disp(statement);
    
    dataSetStruct(i).emotionFeatureVector = emotionFeatureVector;
        
end    
    
    save (structLocation, 'dataSetStruct')
    
   
end
