function ImageResize

cd ..;

reSizeParam = 24;
currentFolder = pwd;
TrainingSetPath = strcat(strrep(currentFolder,'\','/'),'/Test/');
ImageFilePath = fullfile(strrep(TrainingSetPath,'\','/'), '*.jpg');

cd FaceRecognition;

ImageFiles = dir(char(ImageFilePath));
for i = 1:length(ImageFiles)
    ImageFileName = ImageFiles(i).name;
    FullFileName = fullfile(TrainingSetPath, ImageFileName);
    image = imread(char(FullFileName));
    if(size(image,3)==3)
        imagePixel = (rgb2gray(image));
    else
        imagePixel = (image);
    end
    
    imageMatrix = imresize(imagePixel,[reSizeParam reSizeParam]);
    fileName =[TrainingSetPath,ImageFileName];
    imwrite(imageMatrix,fileName,'jpg');
end



end

