neutralFacesPath='D:\00xBeds\07-EmotionBed\02-Data\EmotionDet\TrngTestSets\tkalcic\neutral_faces';
facesMainPath='D:\00xBeds\07-EmotionBed\02-Data\EmotionDet\TrngTestSets\tkalcic\faces';

neutralFacesStruct= dir(neutralFacesPath);

userExpresivity=0;
for i=3:size(neutralFacesStruct,1)
        
    index=1;
    difference=0;
    currentUser=neutralFacesStruct(i).name(1:end-4);
    disp(['current user(' num2str(i) '/53):' currentUser])
    
    neutralFaceName=neutralFacesStruct(i).name;
    
    neutralFaceFile = [neutralFacesPath '\' neutralFaceName];
    neutralFace = imread (neutralFaceFile);
    
    emotionsStruct= dir([facesMainPath '\' num2str(currentUser)]);
    
    for j= 3:size(emotionsStruct,1)
       
        emotionName=emotionsStruct(j).name;
        framesStruct = dir([facesMainPath '\' num2str(currentUser) '\' emotionName]);
        
        for k= 3:size(framesStruct,1)
            
            frameName=framesStruct(k).name;
            if(frameName(end-3:end) ~= '.png')
                continue;
            end
            
            frameFile = [facesMainPath '\' num2str(currentUser) '\' emotionName '\' frameName];
            frame = imread(frameFile);
            
            if(size(neutralFace,1)~=size(frame,1) || size(neutralFace,2)~=size(frame,2))
                continue;
            end
            
            %version1
            distance = double(neutralFace(15:105,15:105)) - double(frame(15:105,15:105));
            distance = distance.*distance;
            difference(index) = sum(sum(distance));
            difference(index) = sqrt(difference(index));
            index=index+1;
            
        
                        
        end
        
    end
    
    
    userExpresivity(str2num(currentUser))=mean(difference);
    
    
end
