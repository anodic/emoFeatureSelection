% function createXMLTrngTestSet creates a 'TrngTestSet.xml' file with
% information from the DataSetFeatureVectors folder.
% 
% @param dataSetPath            data set path
% @param thisTrngTestSetFN      name for the xml file
% @return retQ                  true if Ok and false otherwise
%
function [] = LDOSPerAffCreateXMLTrngTestSetMultiple(DataSetFeatureVectorsPath)


%if (isempty(thisTrngTestSetFN)) 
%    thisTrngTestSetFN = 'TrngTestSet.xml'; 
%end;


thisTrngTestSetFN = 'TrngTestSet.xml';


list = dir(DataSetFeatureVectorsPath);

trainingSampleAbsoluteIndx = 1;


for i=3:size(list,1)
    
    fileName = list(i).name;
    
    % checking if the file is a .mat file
    nameSize =  size(fileName,2);
    if (~strcmp( fileName(nameSize-3:nameSize) ,'.mat'))
        continue;
    end
    
    % from the name of the file get the "emotion" part
    className = fileName(end-6:end-6);
    
    if (className ~= '7')
        classID = className;
    else
        classID = 6;
    end
    
    
    statement = ['Vector ' int2str(i) ' of ' int2str(size(list,1)) ' calculated!'];
    disp(statement);
     
    % writing the information in the xml file    
    newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).ATTRIBUTE.clsId = classID;
    newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).ATTRIBUTE.clsName = className;
    newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).ATTRIBUTE.fileName = fileName;
    newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).CONTENT = 'Opis';
    trainingSampleAbsoluteIndx = trainingSampleAbsoluteIndx + 1;
    
end

newTrngTestSetXML.TrngTestSet.ATTRIBUTE.dDir='./';
newTrngTestSetXML.TrngTestSet.ATTRIBUTE.numElts = num2str(trainingSampleAbsoluteIndx-1);
newStrTrngTestSetXML = xml_formatany(newTrngTestSetXML);

fid = fopen(fullfile(DataSetFeatureVectorsPath, thisTrngTestSetFN),'wt');
fprintf(fid, '<?xml version="1.0" encoding="utf-8"?>\n');
fprintf(fid, newStrTrngTestSetXML);
status = fclose(fid);


end




