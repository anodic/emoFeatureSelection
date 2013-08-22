function [] = createDataSetPerCategorie()

dataSetPath = 'D:\00xBeds\07-EmotionBed\02-Data\EmotionDet\TrngTestSets\tkalcic'

absDataFileName ='D:\Research\04-EmotionExpressivity\merged.xlsx'
sheetName = 'categories'
categoriesRange = 'B2:B150';

categories = xlsread(absDataFileName, sheetName, categoriesRange);


% loading the dataSetStruct 
dataSetStructLocation = [dataSetPath '\' 'dataSetStruct.mat'];
load (dataSetStructLocation)

% creating a folder
mkdir(dataSetPath,'DataSetFeatureVectorsLOW')

% creating a vector file name, creating a .mat file and saving the vector
% in the folder
for i=1:size(dataSetStruct,2)
    
    cat=str2num(dataSetStruct(i).personFolder);
    
    if (categories(cat)~=1)
        continue;
    end
    
    vectorName = [dataSetStruct(i).personFolder 'e' dataSetStruct(i).emotionFolder 'c' int2str(dataSetStruct(i).emotion) 'v' int2str(dataSetStruct(i).version)];
    vectorFullLocation = [dataSetPath '\' 'DataSetFeatureVectorsLOW' '\' vectorName '.mat'];
    emotionFeatureVector = dataSetStruct(i).emotionFeatureVector;
    save (vectorFullLocation, 'emotionFeatureVector');

end

%%%%%%%%%%%%%%%create XML%%%%%%%%%%%%%%%%%%%%

thisTrngTestSetFN = 'TrngTestSet.xml';
DataSetFeatureVectorsPath = [dataSetPath '\' 'DataSetFeatureVectorsLOW'];

list = dir(DataSetFeatureVectorsPath);

trainingSampleAbsoluteIndx = 1;


for i=3:size(list,1)
    
    fileName = list(i).name;
    
    % checking if the file is a .mat file
    nameSize =  size(fileName,2);
    if (~strcmp( fileName(nameSize-3:nameSize) ,'.mat'))
        continue;
    end
    
    className = fileName(end-6:end-6);
    
    if (className ~= '7')
        classID = className;
    else
        classID = 6;
    end
    
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