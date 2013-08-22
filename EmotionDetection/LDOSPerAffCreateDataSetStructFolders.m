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
function [dataSetStruct] = LDOSPerAffCreateDataSetStructFolders(dataSetPath)

dataSetStruct = struct;
load PerAffMD.mat
index = 1;

dataSetFacesPath = [dataSetPath, '\faces']

personList = dir(dataSetFacesPath);
for i=3:size(personList,1)
    personFolder = personList(i).name;
        
    emotionList = dir([dataSetFacesPath '\' personFolder]);
    for j=3:size(emotionList,1)
        emotionFolder = emotionList(j).name;
        
       % refMatIndex = [personFolder 'e' emotionFolder];
        
       
       emotionID = str2num(emotionFolder);
            
            for i=1:70
                if(PerAffMD(i) == emotionID)
                    emotion = PerAffMD(i,5);
                    break;
                end
            end
              
        for k=1:5
                                              
            dataSetStruct(index+k-1).emotion = emotion;
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
