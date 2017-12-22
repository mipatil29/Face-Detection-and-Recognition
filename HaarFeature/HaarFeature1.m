function [HaarFea1] = HaarFeature1(imageMatrix)


[windowMatrixRows,windowMatrixCols] = size(imageMatrix);

divideCols = windowMatrixCols/2;

cd ../FaceDetection

S1 = IntegralImage(imageMatrix(:,1:divideCols));
S2 = IntegralImage(imageMatrix(:,divideCols+1:end));

HaarFea1 = S1-S2;

cd ../HaarFeature

end

