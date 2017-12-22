function captureQueryImage(ProcessType)

cd ..;
currentFolder = pwd;
trainingSetPath = strcat(strrep(currentFolder,'\','/'),'/QueryImage/');

cd FaceRecognition;

try

    if strcmp(ProcessType,'FACERECOGNITION')
    reSizeParam = 24;

    % Create a cascade detector object.
    faceDetector = vision.CascadeObjectDetector();
    % Read a image from Web Cam and run the detector.
    imgWebCam = videoinput('winvideo',1);
    queryImg= getsnapshot(imgWebCam);
    queryImg = rgb2gray(queryImg);
    boundarybox = step(faceDetector, queryImg);
    % cropping Face only
    imgCrop = imcrop(queryImg,boundarybox);
    imageMatrix = imresize(imgCrop,[reSizeParam reSizeParam]);

    else

    reSizeParam = 24;
    vid = videoinput('winvideo', 1);
    set(vid, 'ReturnedColorSpace', 'RGB');
    queryImageSnapShot = getsnapshot(vid);
    queryImageSnapShot = rgb2gray(queryImageSnapShot);
    % resizing an Image
    imageMatrix = imresize(queryImageSnapShot,[reSizeParam reSizeParam]);

    end

    % writing Query Image in a File
    fname =[trainingSetPath,'queryImage.jpg'];
    imwrite(imageMatrix,fname,'jpg');

catch
    error('Your Face is not Detect by Camera.');
end


end

