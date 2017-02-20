# create image for a given equation
# find frequency domain 



fx = 20;
fy = 10 ;
x = [1:100] ;
y = [1:100] ;
Ix = meshgrid(x,y) ;
t = 1/40 ;   

sin_para = sin(2 .* pi .* fx .* Ix .* t ) ;
new_f = (sin_para + 1 ) .* (255/2) ;


new1 = fft2(double(new_f));
new1 = abs(fftshift(new1));
subplot(122);
imshow(new1); 


new_f = uint8(new_f) ;
subplot(121);
imshow(new_f)
