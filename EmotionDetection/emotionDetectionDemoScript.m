%emotionDetectionDemoScript

load 'gaborFilterBank.mat'

% get the filenames
fileFolder = fullfile('D:\Research\emotionDetection\demo\demoData');
dirOutput = dir(fullfile(fileFolder,'out*.jpg'));
fileNames = {dirOutput.name}';
for i = 1:size(fileNames,1)
    fileNames{i} = ['D:\Research\emotionDetection\demo\demoData\' , fileNames{i}];
end


% do for all filenames
for i =1:size(fileNames,1)

%load image
originalImage=imread(fileNames{i});

% get full image, cropped image and gabor filtered montage

[croppedImage] = croppingViolaJones(originalImage);
croppedImage=rgb2gray(croppedImage);

[frameFilteredImages] = applyGabogFilterBankToFrame(croppedImage, gaborFilterBank);
[montagedGaborImgs] = montageGaborImages(frameFilteredImages);
montagedGaborImgs = im2uint8(montagedGaborImgs);

[ eyesMouthImage ] = eyesAndMouthLocator( croppedImage );


% resize images to hight 300

resizedImage=imresize(originalImage,300/size(originalImage,1));
sceneImage=imcrop(resizedImage, [50 1 299 299]);
%resultResizedImage = cat(3,sceneImage,sceneImage,sceneImage); 

resizedCroppedImage=imresize(croppedImage,300/size(croppedImage,1));
resultResizedCroppedImage = cat(3,resizedCroppedImage,resizedCroppedImage,resizedCroppedImage); 

resizedMontagedGaborImgs=imresize(montagedGaborImgs,300/size(montagedGaborImgs,1));
resultResizedMontagedGaborImgs = cat(3,resizedMontagedGaborImgs,resizedMontagedGaborImgs,resizedMontagedGaborImgs); 


resizedEyesMouthImage=imresize(eyesMouthImage,300/size(eyesMouthImage,1));
% create movie frame
%fullDemoFrame=[resultResizedImage, resultResizedCroppedImage; resizedEyesMouthImage, resultResizedMontagedGaborImgs ];
fullDemoFrame=[sceneImage, resizedEyesMouthImage, resultResizedMontagedGaborImgs ];

% save the image in a specific folder
framePath = 'D:\Research\emotionDetection\demo\movieFrames\';
filename = ['frame' num2str(220+i) '.jpg'];
fulFramePath = [framePath filename];
imwrite(fullDemoFrame,fulFramePath,'jpg')

% ** matlab function to create movie not good due to a poor compression
% **if(i==1)
% **multiFrameImage = cat(4,fullDemoFrame);
% **else
% **    multiFrameImage = cat(4,multiFrameImage,fullDemoFrame);
% **end



end

% **mov = immovie(multiFrameImage,gray);
% **movie2avi(mov, 'film.avi', 'compression', 'Cinepak');

