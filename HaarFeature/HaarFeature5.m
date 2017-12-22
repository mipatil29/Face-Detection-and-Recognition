function [HaarFea5] = HaarFeature5(imageMatrix)


cd ../FaceDetection

[windowMatrixRows,windowMatrixCols] = size(imageMatrix);

divideRows = floor(windowMatrixRows/2);
divideCols = floor(windowMatrixCols/2);

S1 = IntegralImage(imageMatrix(1:divideRows,1:divideCols));
S2 = IntegralImage(imageMatrix(1:divideRows,divideCols+1:end));
S3 = IntegralImage(imageMatrix(divideRows+1:end,1:divideCols));
S4 = IntegralImage(imageMatrix(divideRows+1:end,divideCols+1:end));

HaarFea5 = S1-S2-S3+S4;

cd ../HaarFeature


end