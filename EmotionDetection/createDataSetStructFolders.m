% function createDataSetStructFolders creates a structure dataSetStruct 
% that contains the information about the data set. This is created from 
% RefTable that was created by hand. Information in dataSetStruct is:
% emotion
% personFolder
% emotionFolder
%
% @param dataSetPath           data set path
% @return dataSetStruct        created structure
%
function [dataSetStruct] = createDataSetStructFolders(dataSetPath)

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
                
        dataSetStruct(index).emotion = RefTable.(strIndex);
        
        dataSetStruct(index).personFolder = personFolder;
        dataSetStruct(index).emotionFolder = emotionFolder;
        index = index+1;
          
        
     end
 end    

    location = [dataSetPath '\' 'dataSetStruct.mat'];

    save (location, 'dataSetStruct')
        
end
