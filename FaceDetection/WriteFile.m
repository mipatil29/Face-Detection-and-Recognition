function WriteFile(A,fid,format)
    
    if fid < 0
        fprint('Error While Opening a file');
        return;
    end

    for i=1:size(A)
            if(format == 'Y')
                fprintf(fid,'%0.2f \t',A(i,:));
            else
                fprintf(fid, '%d \t', A(i,:));
           end
           fprintf(fid, '\n');
    end
       
end