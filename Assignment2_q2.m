
I=imread('city.pgm');
[Gmag, Gdir] = imgradient(I);

figure, imshow(Gmag, []), title('Gradient magnitude')
figure, imshow(Gdir, []), title('Gradient direction')
