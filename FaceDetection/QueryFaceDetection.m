function QueryFaceDetection

cd ..;
currentFolder = pwd;
queryImagePath = strcat(strrep(currentFolder,'\','/'),'/QueryImage/');

cd FaceDetection;

load SVMStruct;

% % calculating the Test image Haar features
disp('----------------------------------------');
disp('Start Calculating Haar Features of Test Image');
queryfeatureCount = 1;
queryImage = imread(strcat(queryImagePath,'queryImage.jpg'));
queryHaarFeatureMatrix = HaarFeature(queryImage);

for k=1:size(queryHaarFeatureMatrix,1)
% %     sumqueryHaarFeatureMatrix = sum(queryHaarFeatureMatrix(k,1:5));
% %     if  sumqueryHaarFeatureMatrix > 10000  && sumqueryHaarFeatureMatrix < 14000
% %     end
     queryFeatureMatrix(queryfeatureCount,:) = queryHaarFeatureMatrix(k,1:5);
     queryfeatureCount = queryfeatureCount + 1;
    
end

disp('-----------------------------------------');
disp('Haar Features Calculation of Test Image Ends');
disp('-----------------------------------------');

% SVM classifier
disp('-----------------------------------------');
disp('Classifier Call Starts');
outlabel = svmclassify(SVMStruct,queryFeatureMatrix);
disp('Classifier Call Ends');
disp('-----------------------------------------');

% % retrieving the co-ordinates which are having label as a face 
m = 1;
for i=1:size(outlabel,1)
    Label = char(outlabel{i});
    if strcmpi(Label,'Face')
        FaceCoordinates(m,1) = i;
        m = m + 1;
    end
end

for i=1:size(FaceCoordinates,1)
      QueryFaceCoordinates(i,1) = queryHaarFeatureMatrix(FaceCoordinates(i,1),6);
      QueryFaceCoordinates(i,2) = queryHaarFeatureMatrix(FaceCoordinates(i,1),7);
end
QueryFaceCoordinates = unique(sortrows(QueryFaceCoordinates),'rows');

% find the min and max co-ordinates values
minX = min(QueryFaceCoordinates(:,1));
maxX = max(QueryFaceCoordinates(:,1));

minY = min(QueryFaceCoordinates(:,2));
maxY = max(QueryFaceCoordinates(:,2));

% creating a boundary box
figure(1) 
queryImage = imread(strcat(queryImagePath,'queryImage.jpg'));
imshow(queryImage);
hold on

x1=[minX,minY];
x2=[minX,maxY];
x3=[maxX,minY];
x4=[maxX,maxY];

plot(x1,x2,'x','LineWidth',2,'Color','green');
plot(x3,x1,'x','LineWidth',2,'Color','green');
plot(x3,x2,'x','LineWidth',2,'Color','green');
plot(x4,x2,'x','LineWidth',2,'Color','green');
plot(x3,x4,'x','LineWidth',2,'Color','green');

end

