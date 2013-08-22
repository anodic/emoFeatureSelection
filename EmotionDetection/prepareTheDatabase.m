% function applyGaborToImage performs convolution between image and gabor
% filter matrix
%
% @param image          input image
% @param gaborFilter    gabor filter matrix
% @return filteredImage filtered image
%
function [] = prepareTheDatabase(dataSetPath)

dataSetStruct = createDataSetStructFoldersMultiple(dataSetPath);

disp('Folders in struct set!')

dataSetStruct = addEmotionFeatureVectorInDataSetStructMultiple(dataSetPath);

disp('Feature vectors calculated and added!')

createDataSetFeatureVectorsFolderMultiple(dataSetPath);

DataSetFeatureVectorsPath = [dataSetPath '\' 'DataSetFeatureVectors'];

createXMLTrngTestSetMultiple(DataSetFeatureVectorsPath, 0);

disp('XML file created!')

end