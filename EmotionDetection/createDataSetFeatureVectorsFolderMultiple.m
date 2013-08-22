% function createDataSetFeatureVectorsFolder creates a folder in a dataset
% parent folder, that contains feature vector for each emotion sequence.
%
% @param dataSetPath           data set path
% @return  dataSetStruct      data set struct
%
function [] = createDataSetFeatureVectorsFolderMultiple(dataSetPath)

% loading the dataSetStruct 
dataSetStructLocation = [dataSetPath '\' 'dataSetStruct.mat'];
load (dataSetStructLocation)

% creating a folder
mkdir(dataSetPath,'DataSetFeatureVectors')

% creating a vector file name, creating a .mat file and saving the vector
% in the folder
for i=1:size(dataSetStruct,2)
    
    vectorName = [dataSetStruct(i).personFolder 'e' dataSetStruct(i).emotionFolder dataSetStruct(i).emotion 'v' int2str(dataSetStruct(i).version)];
    vectorFullLocation = [dataSetPath '\' 'DataSetFeatureVectors' '\' vectorName '.mat'];
    emotionFeatureVector = dataSetStruct(i).emotionFeatureVector;
    save (vectorFullLocation, 'emotionFeatureVector');

end

end