% function createDataSetStructFoldersMultiple creates a structure dataSetStruct 
% that contains the information about the data set. This is created from 
% RefTable that was created by hand. Information in dataSetStruct is:
% emotion
% personFolder
% emotionFolder
%
% @param dataSetPath           data set path
% @return dataSetStruct        created structure
%
function [dataSetStruct] = createDataSetStructFoldersMultiple(dataSetPath)

dataSetStruct = struct;
load RefTable.mat
index = 1;

personList = dir(dataSetPath);
for i=3:size(personList,1)
    personFolder = personList(i).name;
    
    
    emotionList = dir([dataSetPath '\' personFolder]);
    for j=3:size(emotionList,1)
        emotionFolder = emotionList(j).name;
        
        strIndex = [personFolder 'e' emotionFolder];
        
        for k=1:5
            dataSetStruct(index+k-1).emotion = RefTable.(strIndex);
            dataSetStruct(index+k-1).personFolder = personFolder;
            dataSetStruct(index+k-1).emotionFolder = emotionFolder;
            dataSetStruct(index+k-1).version = k;
        end
         index = index+5;
     end
 end    

    location = [dataSetPath '\' 'dataSetStruct.mat'];

    save (location, 'dataSetStruct')
        
end
