I=imread('tower.pgm');
BW=edge(I,'Canny');
imshow(BW)
%{
count_great5=0;
count_great3=0;
for i=1:10
    if (i>5)
        count_great5=count_great5+1;
    elseif(i>3)
        count_great3=count_great3+1;
    end
    
    
end
%}


%{
for i=2:(row-1)
    for j=2:(col-1)
        if (T2(i,j)==0)
          if(T1(i+1,j)~=0) 
              T2(i+1,j)=1;
          elseif(T1(i-1,j)~=0)
              T2(i-1,j)=1;
          elseif(T1(i,j+1)~=0)
              T2(i,j+1)=1;
          elseif(T1(i,j-1)~=0)
              T2(i,j-1)=1;
          elseif(T1(i+1,j+1)~=0)
              T2(i+1,j+1)=1;
          elseif(T1(i+1,j-1)~=0)
              T2(i+1,j-1)=1;
          elseif(T1(i-1,j+1)~=0)
              T2(i-1,j+1)=1;
          elseif(T1(i-1,j-1)~=0)
              T2(i-1,j-1)=1;            
          end
          
            
        end
        
    end
end


T1=zeros(row,col);
T2=zeros(row,col);
for i = 1:row
    for j = 1:col
        if (supressed_im(i,j)>ThreshH)
            T2(i,j)=1;
            
        elseif (supressed_im(i,j)>ThreshL)
            T1(i,j)=1;
        end
    end
end


EDGE=hysthresh(supressed_im,ThreshH,ThreshL);


%}