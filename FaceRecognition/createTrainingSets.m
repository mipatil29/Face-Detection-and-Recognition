function createTrainingSets

warning('off');
      
cd ..;

currentFolder = pwd;
imageLocation = strcat(strrep(currentFolder,'\','/'),'/TrainingSets/');
inputYourName = input('Please Enter Your Name: ','s');
imageName = inputYourName;
inputYourName = strcat(inputYourName,'/');
imageLocation = strcat(imageLocation,inputYourName);
reSizeParam = 24;

cd FaceRecognition;

if ~exist(imageLocation)
    mkdir(imageLocation);
end

try

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

%creating an instance of webCam
imgWebCam = videoinput('winvideo',1);

disp('System will capture your 15 images for training sets');
for i=1:15
        % Taking a snaphot
        imgSnapShot = getsnapshot(imgWebCam);
        imgSnapShot = rgb2gray(imgSnapShot);
        % Determine boundary of a face
        boundarybox = step(faceDetector, imgSnapShot);
        % Cropping face only
        imgCrop = imcrop(imgSnapShot,boundarybox);
        % resizing an Image
        imageMatrix = imresize(imgCrop,[reSizeParam reSizeParam]);
        % For each image file, different name for it.
        trainingImageName = strcat(imageName,num2str(i));
        trainingImageName = strcat(trainingImageName,'.jpg');
        fileName =[imageLocation,trainingImageName];
        % writing a file in a Training set directory
        imwrite(imageMatrix,fileName,'jpg');
        pause(1);
end

catch
    error('Your Face is not Detect by Camera.');
end

end

