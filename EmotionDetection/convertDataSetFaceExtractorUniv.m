% function convertDataSetFaceExtractor takes a data set (dataSetPath), runs DetectHumanFaces on
% the images and saves new smaler images in (resultPath). Folder hierarchy, names and file names
% are perserved.
% @param dataSetPath           source training set
% @param resultPath            destination folder
% @return retQ                  true if Ok and false otherwise
%
function [retQ] = convertDataSetFaceExtractorUniv(dataSetPath, resultPath)

% global settings_absoluteRootPath;
% settings_absoluteRootPath = 'D:\dataSet';

%resultPath = 'D:\result\';

personList = dir(dataSetPath);
for i=3:size(personList,1)
    personFolder = personList(i).name;
    
    
    emotionList = dir([dataSetPath '\' personFolder]);
    for j=3:size(emotionList,1)
        emotionFolder = emotionList(j).name;
        
        thisTrainingSetPath = fullfile(resultPath, personFolder, emotionFolder);
        outTrainingSetPath = fullfile(dataSetPath, personFolder, emotionFolder);
        
        mkdir(thisTrainingSetPath);
        
        fileList = dir( outTrainingSetPath );
        
        
        for k=3:size(fileList,1)
            fileName = fileList(k).name;
            
            l = length(fileName);
            if(~(fileName(l-2:l) == 'png'))
                continue;
            end
            
            fileName2 = ['\', fileName];
            
            tmpImage = imread([outTrainingSetPath fileName2]);
            
            tmpImage = rgb2gray(tmpImage);
            
            tmpImage = imresize(tmpImage, [240 320]);
            
            result = DetectHumanFaces (tmpImage);
            if(isempty(result))
                continue;
            end
            new = imcrop(tmpImage, [result(1) result(2) result(3) result(4)]);
            
            %resize---------->>
            
            newFileName = fileName;
                       
            newFileName = ['\', newFileName];
            
            imwrite (new, [thisTrainingSetPath, newFileName],'jpg');
            
            
        end
        
        
    end
    
    
    
    
    retQ = true;
    
    
    
end
