function CalculationTrainingSets

format shortEng;
format compact;
format 

cd ..;

currentFolder = pwd;
trainingSetPath = strcat(strrep(currentFolder,'\','/'),'/TrainingSets/');


try

    % retriving the Subdirectory names
    d = dir(trainingSetPath);
    subdirnames = {d([d.isdir]).name};
    subdirnames = setdiff(subdirnames, {'.', '..'});  

    for i =  1:length(subdirnames)
       subDirectory(i) = subdirnames(i);
    end

    cd FaceRecognition;

    sizeParam = 24;

    m = 0;
    for i = 1:length(subDirectory)

        % creating a sub directory path
        trainingSetSubFolder = strcat(trainingSetPath,subDirectory(i));
        % For full file name
        filePattern = fullfile(strrep(trainingSetSubFolder,'\','/'), '*.jpg');
        % retriving images from a folder
        imageFiles = dir(char(filePattern));

        for j = 1:length(imageFiles)
            imageFileName = imageFiles(j).name;
            % Creating a full file name for an image
            imageFullFileName = fullfile(trainingSetSubFolder, imageFileName);
            % reading an image
            imageArray = imread(char(imageFullFileName));
            % resizing an image
            imageArray = imresize(imageArray,[sizeParam sizeParam]);
            m = m +1;
            % Storing image in a Matrix (Cell wise)
            imageFileNameMatrix{m} =  {num2str(imageFileName)};
            imageMatrix(:,m) = imageArray(:);
        end
    end

    % logic for calculating the average of all images in a training sets
    noOfImagesTrainingSets = m;
    averageTrainingSetImg = uint8(zeros(sizeParam * sizeParam,1));

    for i=1:noOfImagesTrainingSets
        averageTrainingSetImg = averageTrainingSetImg + ((1/noOfImagesTrainingSets) * (imageMatrix(:,i)));
    end

    % Subtract the averageFace Matrix from All image matrix (to calculate mean Matrix)
    imageMeanFaceMatrix = double(zeros(size(imageMatrix,1),size(imageMatrix,2)));
    for i=1:noOfImagesTrainingSets
        imageMeanFaceMatrix(:,i) = double(imageMatrix(:,i)) - double(averageTrainingSetImg(:,1));
    end

    % storing Mean Face matrix into a Column Matrix
    A = zeros(sizeParam * sizeParam,noOfImagesTrainingSets);
    for i=1:noOfImagesTrainingSets
        A(:,i) = imageMeanFaceMatrix(:,i);
    end

    %Calculateing the co-variance Matrix
    covarianceMatrix = A' * A;

    % Eigen Vector of Co-variance Matrix
    [eigVector,diagVec]  = eig(covarianceMatrix);

    % diagonal elements of a matrix
    diagValues = diag(diagVec);

    % storing diagonal into descending values
    [diagElement,index] = sort(diagValues,'descend');

    eigVector = eigVector(:,index);

    % Multiply eigVector with A matrix 
    eigenFaceMatrix = A * eigVector;

    % Not in use, But very important (reshape each eigen vector for eigen face)
    eigenfaces=[];
    noOfEigenFace = 0;
    for i=1:noOfImagesTrainingSets
        % use reshape for the original matrix form

        eigenfaces{i} = reshape(eigenFaceMatrix(:,i),sizeParam,sizeParam);
        imshow(eigenfaces{i});
        noOfEigenFace = noOfEigenFace + 1;
    end

    % Calculating weight of training images
    for i=1:noOfImagesTrainingSets
          % multiplying each training image transopse with each eigen face
          % so, for 1st image (1st row), number of weights are 1 to number of images 
          % same for others and then sum 
          % sum will add the values in a row and will give the required Output
          WeightTrainingEigenFace(:,i) = (imageMeanFaceMatrix(:,i)' * eigenFaceMatrix);
    end

    % Query Image Calculation
    queryImagePath = strcat(strrep(currentFolder,'\','/'),'/QueryImage/');
    queryImageRead = imread(strcat(queryImagePath,'queryImage.jpg'));
    % queryImageRead = imresize(queryImageRead,[sizeParam sizeParam]);
    queryImage(:,1) = queryImageRead(:);

    % Subtract the averageFace Matrix from query image matrix (to calculate mean Matrix)
    AQueryface = double(queryImage(:)) - double(averageTrainingSetImg(:));

    % Calculating weight of query image
    weightQueryFace(:,1) =  AQueryface' * eigenFaceMatrix;


    %Euclidean distance to compute , however, it has been reported that the Mahalanobis distance 
    m = 1;
    for j=1:noOfImagesTrainingSets  
        diffWeight = 0;
        for i=1:size(weightQueryFace,1)
            diffWeight = diffWeight + (weightQueryFace(i,1) - WeightTrainingEigenFace(i,j)).^2;
        end
        Weight(m,1) = uint64(sqrt(diffWeight));
        m = m + 1;
        
    end

    if min(Weight) <= 4000000
        [x,y] = find(Weight(:,1) == min(Weight));
        strTitle = 'You are: ';
        imageName = regexprep(imageFileNameMatrix{x(1)},'[0-9]+','');
        imageName = regexprep(imageName,'.jpg','');
        imshow(reshape(imageMatrix(:,x(1)),sizeParam,sizeParam));
        title(strcat(strTitle,imageName));
    else
        strTitle = 'Image not found';
        imshow('');
        title(strTitle);
    end
    
catch
    
    error('Error ocuured. Please run again.');
    
end



end
