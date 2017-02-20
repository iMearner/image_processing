clear
pkg load  image

img = imread('fruit.bmp') ;  # read the file  
mask_size = input("\nenter the size of mask (please enter only odd positive integer number)\n" ) ;
my_mask = ones(mask_size,mask_size) ;  # creating the mask of random size 
image_size = size(img);
my_padding = int32(mask_size / 2 ) - 1 ;
# adding noise to image 
my_noise = input("\nenter your choice\n   1) salt & pepper(density = 0.2)\n 2) gaussian noise \n") ;

switch my_noise
  case 1
    img = imnoise(img , "salt & pepper" , 0.2 ) ; 
    case 2
      img = imnoise(img , "gaussian",0,0.1) ;
    
    otherwise
    disp(" \nwrong input ... try again\n ") ;
endswitch

#img = rgb2gray(img) ;   # converting image to gray scale so we can work with them like a 2d array 

my_filter = input("\nwhich filter you want to use 1) Low pass filter 2) High pass filter 3) median filter\n ") ;

switch  my_filter
  case 1
 # this is my low pass filter 
  my_mask = my_mask / (mask_size * mask_size ) ; 
 new_img = zeros( image_size(1) , image_size(2) ) ;
 my_matrix = [1,5,1,5,8;2,6,3,4,8;7,8,9,5,7;4,2,8,6,4;4,2,5,7,9]
 new_mat = ones(5,5) ;
h = 5 ;
w = 5 ; 
 for i = 1:h 
  for j = 1:w
    pixel = 0 ;
     m = 1 ;
    for x = i - my_padding:i+my_padding  
      n = 1 ;   
      for y = j - my_padding : j+my_padding      
        if x < 1 || y < 1 || x > h || y > w
          pixel += 0 ;
         else 
         #disp(m),disp(n);
          pixel += my_matrix(x,y) * my_mask(m,n) ;
         endif
        n += 1 ; 
      endfor
      m =+ 1 ;
    endfor
    new_mat(i,j) = pixel ;
  endfor 
 endfor
 disp(new_mat);
 #new_img = uint8(new_img) ;
 #subplot(121) ;
 #imshow(new_mat) ;
 case 3 
 med_img = ones(image_size(1),image_size(2)) ;
 med_mask = zeros(1,mask_size*mask_size) ;
 for i = 1:image_size(1)
  for j = 1:image_size(2)
  k = 1 ;
    for x = i - my_padding:i+my_padding
      for y = j - my_padding:j+my_padding
      
        if x < 1 || y < 1 || x > image_size(1) || y > image_size(2)
          
         else 
            med_mask(1,k) = img(x,y) ;
            med_mask = sort(med_mask) ;
            pixel = med_mask(1,int32(mask_size / 2)) ;         
         endif
         k += 1 ;
      endfor
      endfor
     med_img(i,j) = pixel ; 
  endfor
 endfor
 med_img = uint8(med_img) ;
 subplot(131)
 imshow(med_img) ;
endswitch
subplot(132 )
imshow(img);

subplot(133)

img = medfilt1(img) ;
imshow(img);
