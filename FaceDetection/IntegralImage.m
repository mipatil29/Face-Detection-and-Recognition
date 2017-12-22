function [integralValue] = IntegralImage(Matrix)

% Creating a matrix of zero 
Integral = zeros(size(Matrix,1),size(Matrix,2));

for i = 1:size(Matrix,1)
    for j = 1:size(Matrix,2)

        if i-1 > 0 
            x = Integral(i-1,j); 
        else
            x = 0;
        end
        
        if j-1 >0 
            y = Integral(i,j-1); 
        else
            y = 0;
        end

        if i-1 >0 && j-1 >0
            z = Integral(i-1,j-1);
        else   
            z = 0;
        end
        
        Integral(i,j) = double(Matrix(i,j)) + double(x) + double(y) - double(z);
        
    end 
end

integralValue = Integral(size(Matrix,1),size(Matrix,2));

end

