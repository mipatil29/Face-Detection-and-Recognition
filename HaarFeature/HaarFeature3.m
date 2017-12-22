function [HaarFea3] = HaarFeature3(imageMatrix)

cd ../FaceDetection

[windowMatrixRows,windowMatrixCols] = size(imageMatrix);

divideRows = floor(windowMatrixRows/2);

S1 = IntegralImage(imageMatrix(1:divideRows,:));
S2 = IntegralImage(imageMatrix(divideRows+1:end,:));

HaarFea3 = S1-S2;

cd ../HaarFeature

end
