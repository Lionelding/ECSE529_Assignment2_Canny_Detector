
FRAMES = 1;
%WIDTH = 640;
%HEIGHT = 480;
HBLANK = 10;%748;
VBLANK = 10;%120;

I=imread('plant.pgm');
[HEIGHT,WIDTH]=size(I);
vidData = double(I);


for f = 1:FRAMES
    xOut = 1;
    yOut = 1;
    vidOut = zeros(HEIGHT, WIDTH, 3);
    
    for y = 0:HEIGHT+VBLANK-1
        for x = 0:WIDTH+HBLANK-1
            if y >= 0 && y < HEIGHT && x >= 0 && x < WIDTH
                pixData = vidData(y+1,x+1,1);
            else
                pixData = 0;
            end
            

            [xOut yOut dataOut] = ...
                mlhdlc_sobelfilter5x5(x, y, pixData);


            if yOut >= 0 && yOut < HEIGHT && xOut >= 0 && xOut < WIDTH
                vidOut(yOut+1,xOut+1,:) = dataOut;
            end  
        end  
    end
    
    figure(1);
    subplot(1,2,1); 
    imshow(uint8(vidData(:,:,1)));
    subplot(1,2,2);
    imshow(uint8(vidOut));
    drawnow;            
            
end

    