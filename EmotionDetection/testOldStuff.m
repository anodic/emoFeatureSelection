function [ image ] = testOldStuff( image )
 Img = double (rgb2gray(image));
   
  % stackOfImgs(:, :, :, ii) = double (rgb2gray(A));
 

   LeftEye = zeros(1,4);
   RightEye = zeros(1,4);
   
   [LeftEye, RightEye] = FaceDetectOrig('haarcascade_mcs_lefteye.xml', 'haarcascade_mcs_righteye.xml', Img);

 

    [dl1, dl2, dl3] = size(LeftEye);
    [dr1, dr2, dr3] = size(RightEye);




    f = figure('visible','off'), imshow(image, 'Border', 'tight');

 
    hold on;

    
    for (ii = 1:dl1)
        if(dl1 >= 1)
            if(dl2 >= 4)
                rectangle('Position',[LeftEye(ii, 1), LeftEye(ii, 2), LeftEye(ii, 3), LeftEye(ii, 4)], 'EdgeColor', 'r', 'LineWidth', 3);
            end
        end
    end
 
     for (ii = 1:dr1)
         if(dr1 >= 1)             
            rectangle('Position',[RightEye(ii, 1),RightEye(ii, 2), RightEye(ii, 3),RightEye(ii, 4)], 'EdgeColor', 'b', 'LineWidth', 3);
             
         end
     end

     hold off;
     
     
     
 
%     format = regexprep(fileName, 'bmp', 'tif');
%     setName = strcat(outputDir, format);
     
 %    print(f, '-r80', '-dtiff', setName);

    


end

