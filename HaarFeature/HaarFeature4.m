function [HaarFea4] = HaarFeature4(imageMatrix)

cd ../FaceDetection

[windowMatrixRows,windowMatrixCols] = size(imageMatrix);

divideRows1 = floor(windowMatrixRows/3);
divideRows2 = windowMatrixRows - divideRows1;

S1 = IntegralImage(imageMatrix(1:divideRows1,:));
S2 = IntegralImage(imageMatrix(divideRows1+1:divideRows2,:));
S3 = IntegralImage(imageMatrix(divideRows2+1:end,:));

HaarFea4 = S1-S2+S3;

cd ../HaarFeature

end