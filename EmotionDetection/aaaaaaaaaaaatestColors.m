%testingColors

image = imread('D:\Research\emotionDetection\imagesFeatures\data\images\2190.jpg');

gray = rgb2gray(image);


% Iind = gray2ind(gray);
% Irgb = ind2rgb(Iind);

%Iind = gray2ind(gray,256);
%Irgb = ind2rgb(Iind,gray(255));

ImageRGB = cat(3,gray,gray,gray); 

% RED = [1,0,0];
% for i = 1:3
%     channel = Irgb(:,:,i);
%     channel(BW) = RED(i);
%     Irgb(:,:,i) = channel;
% end %for
% 
% imshow(Irgb);

