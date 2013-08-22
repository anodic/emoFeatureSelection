% function createDataSetFeatureVectorsFolder creates a folder in a dataset
% parent folder, that contains feature vector for each emotion sequence.
%
% @param dataSetPath           data set path
% @return  dataSetStruct      data set struct
%
function [] = LDOSPerAFFCreateDataSetFeatureVectorsFolderSpecificPerson(dataSetPath)

% loading the dataSetStruct 
dataSetStructLocation = [dataSetPath '\' 'dataSetStruct.mat'];
load (dataSetStructLocation)

% creating a folder
mkdir(dataSetPath,'DataSetFeatureVectors')

% creating a vector file name, creating a .mat file and saving the vector
% in the folder

%load ('ordered.mat')

for i=1:(size(dataSetStruct,2))
    
%     inspect=0;
%     for j=1:30
%       if(str2num(dataSetStruct(i).personFolder) == ordered(j+2,1))
%           inspect = inspect+1;
%       end
%     end
    
%     if (inspect == 0)
%         continue;
%     end

    if((str2num(dataSetStruct(i).personFolder) == 100) || (str2num(dataSetStruct(i).personFolder) == 63))
        
    vectorName = ['p' dataSetStruct(i).personFolder 'e' dataSetStruct(i).emotionFolder 'c' int2str(dataSetStruct(i).emotion) 'v' int2str(dataSetStruct(i).version)];
    vectorFullLocation = [dataSetPath '\' 'DataSetFeatureVectors' '\' vectorName '.mat'];
    emotionFeatureVector = dataSetStruct(i).emotionFeatureVector;
    save (vectorFullLocation, 'emotionFeatureVector');
    statement = ['Vector ' int2str(i) ' of ' int2str(size(dataSetStruct,2)) ' created!'];
    disp(statement);
    
    end

end