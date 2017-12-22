function ReadTrainingSets

cd ..;
currentFolder = pwd;
positiveTrainingSetPath = strcat(strrep(currentFolder,'\','/'),'/PositiveTrainingSets/');
negativeTrainingSetPath = strcat(strrep(currentFolder,'\','/'),'/NegativeTrainingSets/');

cd FaceDetection;

trainingfeatureCount = 1;
posImageFilePath = fullfile(strrep(positiveTrainingSetPath,'\','/'), '*.jpg');
positiveImageFiles = dir(char(posImageFilePath));
disp('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
disp('Positive Images Training Sets');

for i = 1:length(positiveImageFiles)
    positiveImageFileName = positiveImageFiles(i).name;
    posImageFullFileName = fullfile(positiveTrainingSetPath, positiveImageFileName);
    posImageMatrix = imread(char(posImageFullFileName));
    disp('-------------------------------------');
    disp(positiveImageFileName);
    disp('Haar Calculation Started');

    trainingHaarFeatureMatrix = [];
    trainingHaarFeatureMatrix = HaarFeature(posImageMatrix); 
    for k=1:size(trainingHaarFeatureMatrix,1)
        if(sum(trainingHaarFeatureMatrix(k,1:5)) > 0)
           trainingFeatureMatrix(trainingfeatureCount,:) = trainingHaarFeatureMatrix(k,1:5);
           trainingFeatureLabel{trainingfeatureCount} = 'Face';
           trainingfeatureCount = trainingfeatureCount + 1;
        end
    end
    
    disp('Feature Matrix Size: ');
    disp(size(trainingFeatureMatrix));

    disp('Haar Calculation Ended');
    disp('-------------------------------------');
end
disp('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');


disp('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
disp('Negative Images  Training Sets');

negImageFilePath = fullfile(strrep(negativeTrainingSetPath,'\','/'), '*.jpg');
negativeImageFiles = dir(char(negImageFilePath));
for i = 1:length(negativeImageFiles)
    negativeImageFileName = negativeImageFiles(i).name;
    negImageFullFileName = fullfile(negativeTrainingSetPath, negativeImageFileName);
    negImageMatrix = imread(char(negImageFullFileName));

    disp('-------------------------------------');
    disp(negativeImageFileName);
    disp('Haar Calculation Started');
    
    trainingHaarFeatureMatrix = [];
    trainingHaarFeatureMatrix = HaarFeature(negImageMatrix);  
    for k=1:size(trainingHaarFeatureMatrix,1)
         trainingFeatureMatrix(trainingfeatureCount,:) = trainingHaarFeatureMatrix(k,1:5);
         trainingFeatureLabel{trainingfeatureCount} = 'Not Face';
         trainingfeatureCount = trainingfeatureCount + 1;
    end
    disp('Feature Matrix Size: ');
    disp(size(trainingFeatureMatrix));

    disp('Haar Calculation Ended');
    disp('-------------------------------------');
    
end

disp('Feature Matrix Size: ');
disp(size(trainingFeatureMatrix));

disp('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');

save('TrainFeature.mat','trainingFeatureMatrix');
save('TrainFeatureLabel.mat','trainingFeatureLabel');


options.MaxIter = 120000;
disp('Training Positive and Negative Images');
disp('Note: Please wait, Training the images will take time.');
SVMStruct = svmtrain(trainingFeatureMatrix,trainingFeatureLabel,'Options',options);
save('SVMStruct.mat','SVMStruct');


% trainingFeatureMatrix Log
trainingFeatureMatrixLog = strcat(strrep(pwd,'\','/'),'/FileLog/');
Filename = 'TrainingFeatureMatrixLog.txt';
logFilename = strcat(trainingFeatureMatrixLog,Filename);
fid = fopen(logFilename,'wt');
WriteFile(trainingFeatureMatrix,fid,'Y');
fclose(fid);


disp('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
disp('Process Completed');
disp('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');

end