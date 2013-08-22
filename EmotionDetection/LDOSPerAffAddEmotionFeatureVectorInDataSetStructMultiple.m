% function addEmotionFeatureVectorInDataSet calculates emotion feature
% vector and adds it to dataSetStruct. 
%
% @param dataSetPath           data set path
% @return  dataSetStruct       data set struct with added vectors
%
function [dataSetStruct] = LDOSPerAffAddEmotionFeatureVectorInDataSetStructMultiple(dataSetPath)


% loading the dataSetStruct 


dataSetFacesPath = [dataSetPath, '\faces'];
dataSetNeutralFacesPath = [dataSetPath, '\neutral_faces'];

structLocation = [dataSetPath '\' 'dataSetStruct.mat'];
load (structLocation)

% load gabor filter bank
load gaborFilterBank.mat


%creating feature vectors and adding them to a struct
for i=1:size(dataSetStruct,2)
    
    personFolder = dataSetStruct(i).personFolder;
    emotionFolder = dataSetStruct(i).emotionFolder;
    version = dataSetStruct(i).version;
    fulEmotionPath = [dataSetFacesPath '\' personFolder '\' emotionFolder];
    
    
    neutralFrameName = [dataSetNeutralFacesPath '\' personFolder '.png' ];
    
    emotionFeatureVector = LDOSPerAffCreateEmotionFeatureVectorNeutralTopFive(fulEmotionPath, neutralFrameName,  gaborFilterBank, version);
    
    statement = ['Vector ' int2str(i) ' of ' int2str(size(dataSetStruct,2)) ' calculated!'];
    disp(statement);
    
    dataSetStruct(i).emotionFeatureVector = emotionFeatureVector;
        
end    
    
    save (structLocation, 'dataSetStruct')
    
   
end
