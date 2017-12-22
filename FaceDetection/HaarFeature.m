function  [traingFeature] = HaarFeature(imageMatrix)

[ImageRows,ImageColumns] = size(imageMatrix);

featureCount = 1;
for windowMatrixRows=6:6:ImageRows
    for windowMatrixCols=6:6:ImageColumns

        coordinateMatrix = zeros(windowMatrixRows,windowMatrixCols * 2);
        pixelMatrix = zeros(windowMatrixRows,windowMatrixCols);
        
        % logic for Co-ordinate matrix
        ValueX = 0;
        ValueY = 0;
        % creating co-ordinate matrix with value starts from (0,0) - it is
        % 0,0 becoz (ImageRows-windowMatrixRows)+1 and
        % (ImageColumns-windowMatrixCols)+1 has to be add into coordinateMatrix(i,j)
        for i=1:(windowMatrixRows)
               for j=1:(windowMatrixCols * 2)
                  coordinateMatrix(i,j) = ValueX;
                  if(rem(j,2) == 0)
                      coordinateMatrix(i,j) = ValueY;
                      ValueY = ValueY  + 1;
                  end
              end
              ValueY = 0;
              ValueX = ValueX + 1;
        end
        [coordinateMatrixX,coordinateMatrixY] = size(coordinateMatrix);

        % Don't change this thing, very Critical
        % m=1:(ImageRows-windowMatrixRows)+1, otherwise in the last rows we are getting some absurd values 
        % n=1:(ImageColumns-windowMatrixCols)+1, otherwise columns greater
        % than this are getting some absurd values
        for m=1:(ImageRows-windowMatrixRows)+1
           for n=1:(ImageColumns-windowMatrixCols)+1

                    i=1;
                    j=1;

                    pixelMatrixX=1;
                    pixelMatrixY=1;

                    % Retriving near by pixel values of a centerd pixel.
                    while (i <=coordinateMatrixX)
                          while(j <=(coordinateMatrixY))

                               coordinateValueX = coordinateMatrix(i,j);
                               j= j+1;
                               coordinateValueY = coordinateMatrix(i,j);

                               % co-ordinate matrix i,j + imagePixel(m,n)
                               indexX = m+coordinateValueX;
                               indexY = n+coordinateValueY;

                               % checking the range of window
                               if ((indexX <= 0 || indexX > ImageRows || indexX > ImageColumns) || ... 
                                   (indexY <= 0 || indexY > ImageRows || indexY > ImageColumns))

                                     pixelMatrix(pixelMatrixX,pixelMatrixY) = 0;
                               else
                                    pixelMatrix(pixelMatrixX,pixelMatrixY) = imageMatrix(indexX,indexY);
                                    pixelMatrixY = pixelMatrixY+1;
                               end

                               j = j+1;
                          end
                          j = 1;
                          pixelMatrixY = 1;
                          i = i + 1;
                          pixelMatrixX= pixelMatrixX + 1;
                    end
                    
                    cd ../HaarFeature
                   
                    Col = 1;
                    HaarFeature(1,Col) =  HaarFeature1(pixelMatrix);
                    Col = Col + 1;
                    HaarFeature(1,Col) =  HaarFeature2(pixelMatrix);
                    Col = Col + 1;
                    HaarFeature(1,Col) =  HaarFeature3(pixelMatrix);
                    Col = Col + 1;
                    HaarFeature(1,Col) =  HaarFeature4(pixelMatrix);
                    Col = Col + 1;
                    HaarFeature(1,Col) =  HaarFeature5(pixelMatrix);
                    
                    %Image row and column Position
                    Col = Col + 1;
                    HaarFeature(1,Col) =  m;
                    Col = Col + 1;
                    HaarFeature(1,Col) =  n;

                    cd ../FaceDetection

                    traingFeature(featureCount,:) = HaarFeature;
                    featureCount = featureCount + 1;
           end
        end
    end
end

end

