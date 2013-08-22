% function convertTrngSet takes a training set (outerSetPath), runs DetectHumanFaces on
% the images, saves new smaler images in (thisSetPath) and then creates xml
% file. Names of new images and classes are the same as on the original
% images. ClassID changes when the loaded name changes.
% @param thisSetPath            destination folder
% @param thisTrngTestSetFN      name for the xml file
% @param outerSetPath           source training set
% @param methCode               type of a training set
% @return retQ                  true if Ok and false otherwise
%
function [retQ] = convertTrngSet(thisSetPath, thisTrngTestSetFN, outerSetPath, methCode)

global settings_absoluteRootPath;

thisTrainingSetPath = fullfile(settings_absoluteRootPath, thisSetPath);
outTrainingSetPath = fullfile(settings_absoluteRootPath, outerSetPath);
if (isempty(thisTrngTestSetFN)), thisTrngTestSetFN = 'TrngTestSet.xml'; end;

switch (methCode)
    case 'normal'

        fileList = dir( outTrainingSetPath );

        index = 1;
        for i=3:size(fileList,1)
            fileName = fileList(i).name;
            fileName2 = ['\', fileName];
            tmpImage = imread([outerSetPath fileName2]);


            result = DetectHumanFaces (tmpImage);
            new = imcrop(tmpImage, [result(1) result(2) result(3) result(4)]);

            letters = isletter(fileName);

            [val ind] = min(letters);

            newFileName = '';
            for k = 1:ind-1
                newFileName (k)=fileName(k);
            end

            clsName = newFileName;

            if (i == 3)
                doneName = newFileName;
            end
            TF = strcmp(newFileName, doneName);
            if (TF)
                index = index;
            else
                index = 1;
            end

            j = num2str (index);
            newFileName = [newFileName,num2str(j)];
            newFileName = ['\', newFileName];


            imwrite (new, [thisTrainingSetPath, newFileName, '.jpg'],'jpg');
            index = index +1;


            doneName = clsName;
        end

        thisTrngTestSetFN = 'TrngTestSet.xml';
        listing = dir(thisTrainingSetPath);

        trainingSampleAbsoluteIndx = 1;
        currClsId = 1;

        for i=3:size(listing,1)

            fileName = listing(i).name;

            nameSize =  size(fileName,2);
            if (~strcmp( fileName(nameSize-3:nameSize) ,'.jpg'))
                continue;
            end

            letters = isletter(fileName);

            [val ind] = min(letters);


            newFileName = '';
            for k = 1:ind-1
                newFileName (k)=fileName(k);
            end

            if (i == 3)
                doneName = newFileName;
            end


            clsName = newFileName;

            TF = strcmp(newFileName, doneName);
            if (TF)
                currClsId = currClsId;
            else
                currClsId = currClsId +1;
            end


            % newFileName = [newFileName,num2str(j)];


            newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).ATTRIBUTE.clsId = num2str(currClsId);
            newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).ATTRIBUTE.clsName = clsName;
            newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).ATTRIBUTE.fileName = fileName;
            newTrngTestSetXML.TrngTestSet.ClsIdFileName(trainingSampleAbsoluteIndx).CONTENT = 'Opis';
            trainingSampleAbsoluteIndx = trainingSampleAbsoluteIndx + 1;
            doneName = clsName;

        end

        newTrngTestSetXML.TrngTestSet.ATTRIBUTE.dDir='./';
        newTrngTestSetXML.TrngTestSet.ATTRIBUTE.numElts = num2str(trainingSampleAbsoluteIndx-1);
        newStrTrngTestSetXML = xml_formatany(newTrngTestSetXML);

        fid = fopen(fullfile(thisTrainingSetPath, thisTrngTestSetFN),'wt');
        fprintf(fid, '<?xml version="1.0" encoding="utf-8"?>\n');
        fprintf(fid, newStrTrngTestSetXML);
        status = fclose(fid);

        retQ = true;
end
        
        
        
end
