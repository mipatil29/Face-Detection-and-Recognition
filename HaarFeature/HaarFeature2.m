function [HaarFea2] = HaarFeature2(imageMatrix)

[windowMatrixRows,windowMatrixCols] = size(imageMatrix);

cd ../FaceDetection

divideCols1 = floor(windowMatrixCols/3);
divideCols2 = windowMatrixCols - divideCols1;

S1 = IntegralImage(imageMatrix(:,1:divideCols1));
S2 = IntegralImage(imageMatrix(:,divideCols1+1:divideCols2));
S3 = IntegralImage(imageMatrix(:,divideCols2+1:end));

HaarFea2 = S1-S2+S3;

cd ../HaarFeature

end

