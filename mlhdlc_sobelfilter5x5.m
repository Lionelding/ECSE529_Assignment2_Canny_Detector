function [x_out y_out data_out] = ...
            mlhdlc_sobelfilter5x5(x_in, y_in, data_in)
        
persistent lineBuffer1 lineBuffer2 lineBuffer3 lineBuffer4 k 

WIDTH = 640;
HEIGHT = 480;
CMAX = 2000;
Kx = [2 2 4 2 2; ...
      1 1 2 1 1; ...
      0 0 0 0 0;
      -1 -1 -2 -1 -1;
      -2 -2 -4 -2 -2];
Ky = [2 1 0 -1 -2; ...
      2 1 0 -1 -2; ...
      4 2 0 -2 -4;
      2 1 0 -1 -2;
      2 1 0 -1 -2];

if isempty(k)
    k = zeros(5);
end
if isempty(lineBuffer1)
    lineBuffer1 = zeros(1,WIDTH);
    lineBuffer2 = zeros(1,WIDTH);
    lineBuffer3 = zeros(1,WIDTH);
    lineBuffer4 = zeros(1,WIDTH);
end


xTemp = x_in-1;
yTemp = y_in-1;
if xTemp < 0
    xOutTemp = CMAX;
else
    xOutTemp = xTemp;
end
if yTemp < 0
    yOutTemp = CMAX;
else
    yOutTemp = yTemp;
end
if x_in >= 0 && x_in < WIDTH
    dataValid = 1;
else
    dataValid = 0;
end
if dataValid == 1
    lbIndex = x_in+1;
else
    lbIndex = 1;
end
l1 = lineBuffer1(lbIndex);
l2 = lineBuffer2(lbIndex);
l3 = lineBuffer3(lbIndex);
l4 = lineBuffer4(lbIndex);
if dataValid == 1
    lb1WriteValue = l2;
    lb2WriteValue = l3;
    lb3WriteValue = l4;
    lb4WriteValue = data_in;
    l = [l1 l2 l3 l4 data_in]';
else
    lb1WriteValue = l1;
    lb2WriteValue = l2;
    lb3WriteValue = l3;
    lb4WriteValue = l4;
    l = zeros(5,1);
end
lineBuffer1(lbIndex) = lb1WriteValue;
lineBuffer2(lbIndex) = lb2WriteValue;
lineBuffer3(lbIndex) = lb3WriteValue;
lineBuffer4(lbIndex) = lb4WriteValue;
k = [k(:,2:5) l];


if yOutTemp == 0
    k(1,:) = k(3,:);
    k(2,:) = k(3,:);
elseif yOutTemp == HEIGHT-1
    k(4,:) = k(3,:);
    k(5,:) = k(3,:);
end
if xOutTemp == 0
    k(:,1) = k(:,3);
    k(:,2) = k(:,3);
elseif xOutTemp == WIDTH-1
    k(:,4) = k(:,3);
    k(:,5) = k(:,3);
end  
%Gx = conv2(k,Kx,'valid');
%Gy = conv2(k,Ky,'valid');
Gx = 0;
Gy = 0;
for yi = 1:5,
    for xi = 1:5,
        Gx = Gx+k(yi,xi)*Kx(yi,xi);
        Gy = Gy+k(yi,xi)*Ky(yi,xi);
    end
end
G = abs(Gx) + abs(Gy);
Gd = floor(G/4);
Gdm = min(Gd,255);



x_out = xOutTemp;
y_out = yOutTemp;
if yOutTemp < HEIGHT && xOutTemp < WIDTH
    data_out = Gdm;
else
    data_out = 0;
end



