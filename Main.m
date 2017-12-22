function Main

inputOptions = '1';
while(inputOptions == '1')
    
    disp('Press 1 for Face Detection and 2 for Face Recgnition');
    inputChoice = input('What do you want to Test: 1.Face Detection  2.Face Recognition:  ','s');

    if (inputChoice == '1')

        inputFaceDetect = input('1.Test image from Database  2.Capture Your image:  ','s');
        
        if inputFaceDetect == '1' 

        elseif inputFaceDetect == '2'
            
            disp('System will capture your image');
            disp('Please Wait....');

            cd FaceRecognition;
                captureQueryImage('FaceDetection');
            cd ../
            
        else
            disp('Wrong Choice');
        end
        
         cd FaceDetection;
            QueryFaceDetection;
         cd ../           
        
    elseif (inputChoice == '2')

        cd FaceRecognition;

            inputCreateTrainingSets = input('Do You have your faces in a Training Sets  1.Yes  2.No:  ','s');
            
            if inputCreateTrainingSets == '2'
                disp('Please change your Face Expression');
                createTrainingSets;
            end
            
            disp('System is capturing your image as test image');
            disp('Please Wait....');

            captureQueryImage('FACERECOGNITION');

            disp('Face Recognition Starts');
            disp('Please Wait....');

            CalculationTrainingSets;
            
         cd ../

    else
         disp('Wrong Choice');
    end
    
    inputOptions = input('Would You like to continue 1.Continue 2.Quit:  ','s');
    
end

end

