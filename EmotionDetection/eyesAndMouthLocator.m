function [ resultImage ] = eyesAndMouthLocator( image )

grayImage=rgb2gray(image);
resizedImage=imresize(grayImage,[120,120]);
doubleImage=double(resizedImage);

[LeftEye, RightEye, Mouth] = DetectEyesAndMouth('haarcascade_mcs_lefteye.xml', 'haarcascade_mcs_righteye.xml','haarcascade_mcs_mouth.xml', doubleImage)
%[LeftEye, RightEye, Mouth] = FaceDetectEyesMouthCascadeIn(doubleImage)

if(size(LeftEye,1)>1)
    if(LeftEye(1,1)<LeftEye(2,1))
        left=LeftEye(1,:);
    else
        left=LeftEye(2,:);
    end
else
    left=LeftEye(1,:);
end

if(size(RightEye,1)>1)
    if(RightEye(1,1)>RightEye(2,1))
        right=RightEye(1,:);
    else
        right=RightEye(2,:);
    end
else
    right=RightEye(1,:);
end

if(size(Mouth,1)>1)
    if(Mouth(1,2)>Mouth(2,2))
        mouth=Mouth(1,:);
    else
        mouth=Mouth(2,:);
    end
else
    mouth=Mouth(1,:);
end

if (numel(left)==1)
    leftEyeCentre(1) = 1;
    leftEyeCentre(2) = 1;
else
    leftEyeCentre(1) = round(left(1)+left(3)/2);
    leftEyeCentre(2) = round(left(2)+left(4)/2);
end

if (numel(right)==1)
    rightEyeCentre(1) = 1;
    rightEyeCentre(2) = 1;
else
    rightEyeCentre(1) = round(right(1)+right(3)/2);
    rightEyeCentre(2) = round(right(2)+right(4)/2);
end

if (numel(mouth)==1)
    mouthCentre(1) = 1;
    mouthCentre(2) = 1;
else
    mouthCentre(1) = round(mouth(1)+mouth(3)/2);
    mouthCentre(2) = round(mouth(2)+mouth(4)/2);
end
 %rightEyeCentre
 %leftEyeCentre
 %mouthCentre

resultImage = cat(3,resizedImage,resizedImage,resizedImage);

% f = figure, imshow(resultImage, 'Border', 'tight');
% hold on;
% rectangle('Position',[left(1), left(2), left(3), left(4)], 'EdgeColor', 'r', 'LineWidth', 3);
%
% rectangle('Position',[right(1), right(2), right(3), right(4)], 'EdgeColor', 'r', 'LineWidth', 3);
%
% rectangle('Position',[mouth(1), mouth(2), mouth(3), mouth(4)], 'EdgeColor', 'r', 'LineWidth', 3);

%hold off;


for i = -5:5
    if(rightEyeCentre(2)>5)
        resultImage(rightEyeCentre(2),rightEyeCentre(1)+i,1)=255;
        resultImage(rightEyeCentre(2),rightEyeCentre(1)+i,2)=0;
        resultImage(rightEyeCentre(2),rightEyeCentre(1)+i,3)=0;
        resultImage(rightEyeCentre(2)+i,rightEyeCentre(1),1)=255;
        resultImage(rightEyeCentre(2)+i,rightEyeCentre(1),2)=0;
        resultImage(rightEyeCentre(2)+i,rightEyeCentre(1),3)=0;
    end
    
    if(leftEyeCentre(2)>5)
        resultImage(leftEyeCentre(2),leftEyeCentre(1)+i,1)=255;
        resultImage(leftEyeCentre(2),leftEyeCentre(1)+i,2)=0;
        resultImage(leftEyeCentre(2),leftEyeCentre(1)+i,3)=0;
        resultImage(leftEyeCentre(2)+i,leftEyeCentre(1),1)=255;
        resultImage(leftEyeCentre(2)+i,leftEyeCentre(1),2)=0;
        resultImage(leftEyeCentre(2)+i,leftEyeCentre(1),3)=0;
    end
    
    if(mouthCentre(2)>5)
        resultImage(mouthCentre(2),mouthCentre(1)+i,1)=255;
        resultImage(mouthCentre(2),mouthCentre(1)+i,2)=0;
        resultImage(mouthCentre(2),mouthCentre(1)+i,3)=0;
        resultImage(mouthCentre(2)+i,mouthCentre(1),1)=255;
        resultImage(mouthCentre(2)+i,mouthCentre(1),2)=0;
        resultImage(mouthCentre(2)+i,mouthCentre(1),3)=0;
    end
end


%figure, imshow(resultImage);



end

